'
' Created by SharpDevelop.
' User: Evan R. Venn
' Date: 2020

'''
'''Connect the 16f1454 to the USB
'''  D- to porta.1
'''  D+ to porta.0
'''  Cap between Vusb3V3 and 0V
'''  You can provide supply voltage via the USB, or, you can provide local voltage.
'''
''' LEDs to ports suitable resistors as follows:
'''
''' KeepAlive LED PORTA.4
'''
''' REDLED        PORTA.5
''' YELLOWLED     PORTC.0
''' GREENLED      PORTC.1
'''
''' SWITCHES pulled high are as follows:
'''
''' INPUT1        PORTC.2       'IO5
''' INPUT2        PORTC.3       'IO6
''' INPUT3        PORTC.4       'IO7.  Note this is can be used as the Serial Out port.
''' INPUT4        PORTC.5       'IO8

Imports LibUsbDotNet
Imports LibUsbDotNet.Main
Imports LibUsbDotNet.DeviceNotify
Imports System.Timers






Public Partial Class MainForm


    'Constants for communication to PIC - must match the constants in the PIC program.
    Public Const USBDEVICEREADREDLEDSTATUS = 130
    Public Const USBDEVICESETREDLEDON = 131
    Public Const USBDEVICESETREDLEDOFF = 132

    Public Const USBDEVICEREADYELLOWLEDSTATUS = 133
    Public Const USBDEVICESETYELLOWLEDON = 134
    Public Const USBDEVICESETYELLOWLEDOFF = 135

    Public Const USBDEVICEREADGREENLEDSTATUS = 136
    Public Const USBDEVICESETGREENLEDON = 137
    Public Const USBDEVICESETGREENLEDOFF = 138

    Public Const USBDEVICEREADADCVALUES = 139
    Public Const USBDEVICERPORTSTATUS = 140


    '**************** YOU MAY CHANGE THE CONSTANTS ABOVE... Also, look for section marked 'adapt' to add/revise functionality
    'Constants - do not changed
    Public Const DEVICEBITON = 1
    Public Const DEVICEBITOFF = 0

    'Allocated VID and PID to this type of this USB solution - this is a LIBL/WinUSB library solution
    Public Const USB_VID = &H1209
    Public Const USB_PID = &H2006
    Public Const USB_REV = &H0


    'Application Support- DO NOT CHANGE
    Public Const CONSTDEVICEKEEPALIVE = 255

    'Set up USB change event to handle disconnections etc
    Public Shared UsbDeviceNotifier As IDeviceNotifier = DeviceNotifier.OpenDeviceNotifier()

    'Set up objects and variables we need - do not change
    Public Device As UsbDevice
    Private _timer As Timer
    Shared KeepAliveCounter As Integer
    Shared KeepAliveError As Boolean
    Shared GetStatusfromDeviceUponInit As Boolean
    Shared tempvalue As Byte

    'Set up a variable used to track the user interface
    Shared orginalfooterRightText As String


    Delegate Sub InvokeDelegate()

    Public Sub New()
        ' The Me.InitializeComponent call is required for Windows Forms designer support.
        Me.InitializeComponent()
        ConnectionStatus.Select()

        'Store the orignal UI value - we update later
        orginalfooterRightText = footerRightText.Text

        'Flag to track status of reading the status of the LED when init/reinit of applicatiom
        GetStatusfromDeviceUponInit = True

        'Find USB device
        FindUSBDevice()

        ' Hook the device notifier event - do not remove
        AddHandler UsbDeviceNotifier.OnDeviceNotify, AddressOf OnUSBDeviceEventRaised


        'init the timer - this one 1s manages the KeepAlive - do not remove/touch!
        _timer = New System.Timers.Timer()
        _timer.Interval = 1000
        AddHandler _timer.Elapsed, AddressOf OneSecondTimerHandler
        ' Have the timer fire repeated events (true is the default)
        _timer.AutoReset = True
        _timer.Enabled = True
        KeepAliveCounter = 0
        'end of the KeepAlive handler

    End Sub



    'User Interaceface methods


    Public Sub UpdateFormWithLatestData_UserSolution()

        Try
            'Update  application
            If Not Device Is Nothing Then
                ConnectionStatus.Text = "USB device connected"

                'Update the UI  
                ConnectionStatus.BackColor = System.Drawing.Color.LimeGreen
                ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.None

                'If we are init or reinit USB channel so get the LED state from the USB
                If GetStatusfromDeviceUponInit = True Then
                    'We need the removed board to be settled. 1s should be enough.
                    Delay(1)


                    'Adapt here - Set the buttons up
                    'Get the LED status
                    SetLEDStatus1.Checked = ReadDeviceBitStatus_UserSolution(USBDEVICEREADREDLEDSTATUS)
                    If SetLEDStatus1.Checked = True Then
                        RedLED.Visible = True
                        BlackLED1.Visible = False
                    Else
                        RedLED.Visible = False
                        BlackLED1.Visible = True
                    End If

                    'Get the LED status
                    SetLEDStatus2.Checked = ReadDeviceBitStatus_UserSolution(USBDEVICEREADYELLOWLEDSTATUS)
                    If SetLEDStatus2.Checked = True Then
                        YellowLED.Visible = True
                        BlackLED3.Visible = False
                    Else
                        YellowLED.Visible = False
                        BlackLED3.Visible = True
                    End If

                    'Get the LED status
                    SetLEDStatus3.Checked = ReadDeviceBitStatus_UserSolution(USBDEVICEREADGREENLEDSTATUS)
                    If SetLEDStatus3.Checked = True Then
                        GreenLED.Visible = True
                        BlackLED3.Visible = False
                    Else
                        GreenLED.Visible = False
                        BlackLED3.Visible = True
                    End If
                    'End of adapt here

                    GetStatusfromDeviceUponInit = False
                End If
                'Update some text
                VenPidText.Text = Device.Info.ProductString '
                'Update the timeout string
                footerRightText.Text = StrDup(KeepAliveCounter, ".") + orginalfooterRightText
                'Enable the UI
                PollValues.Enabled = True

                'Adapt here - Set the buttons status
                SetLEDStatus1.Enabled = True
                SetLEDStatus2.Enabled = True
                SetLEDStatus3.Enabled = True

                'End of adapt here

            Else

                ConnectionStatus.Text = "USB device not connected"
                'Paint Red
                If ConnectionStatus.BackColor <> System.Drawing.Color.Red Then
                    ConnectionStatus.BackColor = System.Drawing.Color.Red
                Else
                    ConnectionStatus.BackColor = Me.BackColor
                End If
                ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
                VenPidText.Text = ""
                'Disable the UI
                PollValues.Enabled = False

                'Adapt here - Set the buttons status
                SetLEDStatus1.Enabled = False
                SetLEDStatus2.Enabled = False
                SetLEDStatus3.Enabled = False
                'End of adapt here

                'Do not move this call
                ConnectionStatus.Select()
            End If
        Catch
            'exit gracefully
        End Try

        'Anyway we have updated the form!!!

    End Sub 'UpdateFormWithLatestData

    'Adapt this method to add more ADCs
    'Read ADC button was clicked, read ADC values
    Sub PollADCValuesClick_UserSolution(sender As Object, e As EventArgs) Handles PollValues.Click

    End Sub

    'Adapt this method to adapt port stats
    'Read port status button was clicked, read values
    Sub PollPortStatusClick_UserSolution(sender As Object, e As EventArgs) Handles PollValues.Click
        Dim Reply As Byte()
        'Send request DeviceReadADCValues, which means read bytes values from PIC. Reads 4 bytes back.
        Reply = ReadReplyData(USBDEVICERPORTSTATUS, 8)
        If Not Reply Is Nothing Then
            'If there is a reply, update
            If Reply.Length >= 2 Then
                IO1Value.Text = Reply(0).ToString
            End If
            If Reply.Length >= 3 Then
                IO2Value.Text = Reply(1).ToString
            End If
            If Reply.Length >= 4 Then
                IO3Value.Text = Reply(2).ToString
            End If
            If Reply.Length >= 5 Then
                IO4Value.Text = Reply(3).ToString
            End If
        End If
    End Sub



    'Status of the check changed, send commands to turn bits on the PIC on or off
    Sub SetDeviceStatusCheckedChangedHighOn_UserSolution(sender As Object, e As EventArgs) Handles SetLEDStatus3.CheckedChanged, SetLEDStatus2.CheckedChanged, SetLEDStatus1.CheckedChanged


#Disable Warning BC42017 ' Late bound resolution
        Select Case CType(sender.name, String)
#Enable Warning BC42017 ' Late bound resolution
' Adapt below here - to add a handler, additional case statements, for more LEDs and the related checkboxes
            'Handle the event when you select a check box	
            Case "SetLEDStatus1"
                If SetLEDStatus1.Checked Then
                    'To turn on, PIC expects request 
                    SendCommand(USBDEVICESETREDLEDON, DEVICEBITON)
                    RedLED.Visible = True
                    BlackLED1.Visible = False

                Else
                    'To turn off, PIC expects request 
                    SendCommand(USBDEVICESETREDLEDOFF, DEVICEBITOFF)
                    RedLED.Visible = False
                    BlackLED1.Visible = True
                End If

            Case "SetLEDStatus2"
                If SetLEDStatus2.Checked Then
                    'To turn on, PIC expects request 
                    SendCommand(USBDEVICESETYELLOWLEDON, DEVICEBITON)
                    YellowLED.Visible = True
                    BlackLED2.Visible = False

                Else
                    'To turn off, PIC expects request 
                    SendCommand(USBDEVICESETYELLOWLEDOFF, DEVICEBITOFF)
                    YellowLED.Visible = False
                    BlackLED2.Visible = True
                End If

            Case "SetLEDStatus3"
                If SetLEDStatus3.Checked Then
                    'To turn on, PIC expects request 
                    SendCommand(USBDEVICESETGREENLEDON, DEVICEBITON)
                    GreenLED.Visible = True
                    BlackLED3.Visible = False

                Else
                    'To turn off, PIC expects request 
                    SendCommand(USBDEVICESETGREENLEDOFF, DEVICEBITOFF)
                    GreenLED.Visible = False
                    BlackLED3.Visible = True
                End If

        End Select

    End Sub

    'Read the status of a Bit and return the value
    Function ReadDeviceBitStatus_UserSolution(USBDeviceRequestID As Byte) As Boolean

        Dim Reply As Byte()

        'Send USBDeviceRequestID. Read 1 byte back.
        Reply = ReadReplyData(USBDeviceRequestID, 1)
        If Not Reply Is Nothing Then
            'If there is a reply 
            If Reply(0) = 1 Then

                Return True

            End If
        End If

        Return False

    End Function

    'Everything after this should not be changed.

    'Utility functions

    'Find the USB device - do not change
    Function FindUSBDevice() As Boolean

        'Find device
        Dim Finder As New UsbDeviceFinder(USB_VID, USB_PID, USB_REV)

        Try
            Device = UsbDevice.OpenUsbDevice(Finder)
        Catch
            Device = Nothing
        End Try

        If Not Device Is Nothing Then
            GetStatusfromDeviceUponInit = True
        End If

        Return Not Device Is Nothing
    End Function

    'Send a command (control transfer) to the device, no reply expected - do not change
    Sub SendCommand(Request As Byte, Param As Short)

        _timer.Interval = 10000

        'Check for device
        If Device Is Nothing Then Exit Sub

        Try
            'Create setup packet
            'First parameter is RequestType, see LibUsbDotNet documentation for bit usage
            '66 means:
            '          Data direction is host to device
            '          Request type is vendor defined (ie, by us)
            '          Packet is sent to the whole device, not a specific endpoint
            'This should be suitable for any cases when data is being sent to the PIC.
            Dim SetupPacket As New UsbSetupPacket(66, Request, Param, 0, 0)
            'Dummy variables for data to send (none in this case)
            Dim InBuffer(1024) As Byte
            Dim inCount As Integer = 0
            'Send command
            Device.ControlTransfer(SetupPacket, InBuffer, 1000, inCount)
        Catch
            'exit gracefully	
        End Try

        KeepAliveCounter = 0
        _timer.Interval = 1000
        _timer.Enabled = True

    End Sub

    'Send a control transfer and get data from device - do not change
    Function ReadReplyData(Request As Byte, ReplySize As Short) As Byte()

        _timer.Interval = 10000

        'Check for device
        If Device Is Nothing Then Return Nothing

        'Create setup packet
        'First parameter is RequestType, see LibUsbDotNet documentation for bit usage
        '194 means:
        '          Data direction is device to host
        '          Request type is vendor defined (ie, by us)
        '          Packet is sent to the whole device, not a specific endpoint
        'This should be suitable for any cases when data is being read from the PIC.
        'Last parameter is the number of bytes to request back - device may ignore.
        Dim SetupPacket As New UsbSetupPacket(194, Request, 0, 0, ReplySize)
        'Prepare buffers for incoming data
        Dim InBuffer(1024) As Byte
        Dim copyLoc As Integer
        Dim inCount As Integer

        Try
            'Start control transfer
            Device.ControlTransfer(SetupPacket, InBuffer, ReplySize, inCount)
        Catch

        End Try
        'Create an appropriately sized output array, fill with the data
        Dim OutBuffer(inCount) As Byte
        For copyLoc = 0 To inCount - 1
            OutBuffer(copyLoc) = InBuffer(copyLoc)
        Next

        KeepAliveCounter = 0
        'Set the 1s timer
        _timer.Interval = 1000
        _timer.Enabled = True

        Return OutBuffer
    End Function


    'KeepAlive Check Send the constant 'CONSTDEVICEKEEPALIVE' and expect 'CONSTDEVICEKEEPALIVE' back - do not change
    Sub PollKeepAlive()
        Dim Reply As Byte()
        KeepAliveError = False
        'Send request CONSTDEVICEKEEPALIVE, which means KEEPALIVE. Read 1 byte back.
        Reply = ReadReplyData(CONSTDEVICEKEEPALIVE, 1)
        tempvalue = Reply(0)

        If Not Reply Is Nothing Then
            'If there is a reply 
            If Reply(0) <> CONSTDEVICEKEEPALIVE Then
                KeepAliveError = True
                Device.Close()
                Device = Nothing

            End If
        End If
    End Sub


    'On close of main form, close USB device - do not change
    Sub MainFormFormClosed(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        'Close USB device if one was opened
        If Not Device Is Nothing Then
            Device.Close()
        End If

        Try
            ' Disable the device notifier
            UsbDeviceNotifier.Enabled = False
            ' Unhook the device notifier event
            RemoveHandler UsbDeviceNotifier.OnDeviceNotify, AddressOf OnUSBDeviceEventRaised
        Catch
            'exit gracefully
        End Try

    End Sub

    'Event methods
    ' USB event - do not change
    Sub OnUSBDeviceEventRaised(sender As Object, e As DeviceNotifyEventArgs)
        ' A Device system-level event has occured

        Try
            If (e.Device.IdProduct = USB_PID) And (e.Device.IdVendor = USB_VID) Then

                If (e.EventType = &H8004) Then

                    If Not Device Is Nothing Then
                        Device.Close()
                        Device = Nothing
                    End If
                    ConnectionStatus.BeginInvoke(New InvokeDelegate(AddressOf UpdateFormWithLatestData_UserSolution))

                End If
            End If
        Catch
            'exit gracefully
        End Try

    End Sub

    'Timer functions  - do not change

    Public Sub OneSecondTimerHandler(ByVal sender As Object, ByVal e As ElapsedEventArgs)


        Try
            _timer.Enabled = False

            ' If the Device has gone off line the device is nothing
            If Device Is Nothing Then
                'Find USB device
                FindUSBDevice()
                'If the Device has been located then.. poll it, if the poll fails then Device will be set to Nothing, so, dont set the keep alive as need it to keep retrying
                If Not Device Is Nothing Then
                    PollKeepAlive()
                    If Not Device Is Nothing Then
                        'time out the keepalive
                        KeepAliveCounter = 9
                    End If
                End If

            End If

            If Not Device Is Nothing Then
                'every 10 seconds poll the device
                If KeepAliveCounter = 9 Then
                    PollKeepAlive()
                    KeepAliveCounter = 0
                Else
                    KeepAliveCounter = KeepAliveCounter + 1
                End If
            Else
                'Will keep re-trying keep alive, only if, the USB is active.
                KeepAliveCounter = 9
            End If

            _timer.Interval = 1000
            _timer.Enabled = True
            ConnectionStatus.BeginInvoke(New InvokeDelegate(AddressOf UpdateFormWithLatestData_UserSolution))
        Finally
            'exit gracefully
        End Try

    End Sub


    Private Sub Delay(ByVal DelayInSeconds As Integer)
        Dim ts As TimeSpan
        Dim targetTime As DateTime = DateTime.Now.AddSeconds(DelayInSeconds)
        Do
            ts = targetTime.Subtract(DateTime.Now)
            'Application.DoEvents() ' keep app responsive
            System.Threading.Thread.Sleep(50) ' reduce CPU usage
        Loop While ts.TotalSeconds > 0
    End Sub

    Private Sub PictureBox2_Click(sender As Object, e As EventArgs) Handles GreenLED.Click

    End Sub

    Private Sub textBox1_TextChanged(sender As Object, e As EventArgs)

    End Sub

    Private Sub MainForm_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub

    Private Sub groupBox3_Enter(sender As Object, e As EventArgs)

    End Sub

    Private Sub BlackLED2_Click(sender As Object, e As EventArgs) Handles YellowLED.Click, BlackLED3.Click

    End Sub
End Class

