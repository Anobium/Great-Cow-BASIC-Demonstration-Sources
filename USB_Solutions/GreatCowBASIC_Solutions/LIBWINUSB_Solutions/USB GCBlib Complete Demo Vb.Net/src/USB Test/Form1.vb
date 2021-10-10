'USB Demo for the GCBlib USB Library
Imports GCBlib
Public Class Form1
    Dim USB As New USBlib
    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Initialize USB daemon from start
        USB.InitializeUSB()


        'You can define a specific USB PID, REV and VID, if not used the default GCB test pids will be used (works with the current USB driver)
        'USB.USB_PID =
        'USB.USB_REV =
        'USB.USB_VID =

    End Sub
    Private Sub TimerDeviceConnection_Tick(sender As Object, e As EventArgs) Handles TimerDeviceConnection.Tick
        'Get the device connection status
        If USB.GetConnectedStatus = True Then
            Label1.Text = "Device Connected"
        Else
            Label1.Text = "Device not Connected"
        End If
        'Show if the USB daemon is running
        DaemonStatusRadioButton.Checked = USB.Initialized
    End Sub
    Private Sub HelloButton_Click(sender As Object, e As EventArgs) Handles HelloButton.Click
        'Send a simple command whitouth data
        USB.SendData(100)
    End Sub
    Private Sub LCDlightCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles LCDlightCheckBox.CheckedChanged
        'Send a command and data as Bit
        USB.SendData(102, LCDlightCheckBox.Checked)
    End Sub
    Private Sub ByteTrackBar_Scroll(sender As Object, e As EventArgs) Handles ByteTrackBar.Scroll
        'Send a command and data as Byte
        ByteLabel.Text = ByteTrackBar.Value
        USB.SendData(103, ByteTrackBar.Value)
    End Sub
    Private Sub SendArrayButton_Click(sender As Object, e As EventArgs) Handles SendArrayButton.Click
        'Send a command and a data array
        Dim data(2) As Byte
        data(0) = 100
        data(1) = 255
        data(2) = 22
        USB.SendData(104, data)
    End Sub
    Private Sub GetStatusButton_Click(sender As Object, e As EventArgs) Handles GetStatusButton.Click
        'Poll and read 1 Byte from the device
        PORTaLabel.Text = USB.ReadData(101)
    End Sub
    Private Sub GetArrayButton_Click(sender As Object, e As EventArgs) Handles GetArrayButton.Click
        'Poll and read a data array
        Dim data() As Byte
        data = USB.ReadData(105, 3)
        If data Is Nothing Then
            MsgBox("No data received...")
        Else
            MsgBox("Data Received: " & data(0) & "," & data(1) & "," & data(2))
        End If
    End Sub
    Private Sub StartButton_Click(sender As Object, e As EventArgs) Handles StartButton.Click
        'Initialize USB daemon
        USB.InitializeUSB()
    End Sub
    Private Sub TerminateUSBButton_Click(sender As Object, e As EventArgs) Handles TerminateUSBButton.Click
        'Terminate USB daemon
        USB.TerminateUSB()
    End Sub
End Class
