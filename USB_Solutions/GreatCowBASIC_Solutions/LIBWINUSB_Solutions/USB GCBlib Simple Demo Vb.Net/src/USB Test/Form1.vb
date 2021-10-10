'USB Hello world Demo for the GCBlib USB Library
Imports GCBlib
Public Class Form1
    Dim USB As New USBlib
    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Initialize USB daemon from start
        USB.InitializeUSB()
    End Sub

    Private Sub HelloButton_Click(sender As Object, e As EventArgs) Handles HelloButton.Click
        'Send a simple command whitouth data
        USB.SendData(100)
    End Sub



    Private Sub TimerDeviceConnection_Tick(sender As Object, e As EventArgs) Handles TimerDeviceConnection.Tick
        'Show the device connection status on a label
        If USB.GetConnectedStatus = True Then
            Label1.Text = "Device Connected"
        Else
            Label1.Text = "Device not Connected"
        End If

    End Sub

End Class
