<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.HelloButton = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.TimerDeviceConnection = New System.Windows.Forms.Timer(Me.components)
        Me.GetStatusButton = New System.Windows.Forms.Button()
        Me.PORTaLabel = New System.Windows.Forms.Label()
        Me.LCDlightCheckBox = New System.Windows.Forms.CheckBox()
        Me.ByteTrackBar = New System.Windows.Forms.TrackBar()
        Me.ByteLabel = New System.Windows.Forms.Label()
        Me.SendArrayButton = New System.Windows.Forms.Button()
        Me.StartButton = New System.Windows.Forms.Button()
        Me.TerminateUSBButton = New System.Windows.Forms.Button()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.GetArrayButton = New System.Windows.Forms.Button()
        Me.DaemonStatusRadioButton = New System.Windows.Forms.RadioButton()
        CType(Me.ByteTrackBar, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'HelloButton
        '
        Me.HelloButton.Location = New System.Drawing.Point(40, 125)
        Me.HelloButton.Name = "HelloButton"
        Me.HelloButton.Size = New System.Drawing.Size(204, 90)
        Me.HelloButton.TabIndex = 0
        Me.HelloButton.Text = "Send Hello World"
        Me.HelloButton.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(328, 423)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(166, 20)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Device not Connected"
        '
        'TimerDeviceConnection
        '
        Me.TimerDeviceConnection.Enabled = True
        '
        'GetStatusButton
        '
        Me.GetStatusButton.Location = New System.Drawing.Point(40, 221)
        Me.GetStatusButton.Name = "GetStatusButton"
        Me.GetStatusButton.Size = New System.Drawing.Size(116, 71)
        Me.GetStatusButton.TabIndex = 2
        Me.GetStatusButton.Text = "Get PORTa.1 Status"
        Me.GetStatusButton.UseVisualStyleBackColor = True
        '
        'PORTaLabel
        '
        Me.PORTaLabel.AutoSize = True
        Me.PORTaLabel.Location = New System.Drawing.Point(201, 246)
        Me.PORTaLabel.Name = "PORTaLabel"
        Me.PORTaLabel.Size = New System.Drawing.Size(24, 20)
        Me.PORTaLabel.TabIndex = 3
        Me.PORTaLabel.Text = "---"
        '
        'LCDlightCheckBox
        '
        Me.LCDlightCheckBox.AutoSize = True
        Me.LCDlightCheckBox.Checked = True
        Me.LCDlightCheckBox.CheckState = System.Windows.Forms.CheckState.Checked
        Me.LCDlightCheckBox.Location = New System.Drawing.Point(324, 286)
        Me.LCDlightCheckBox.Name = "LCDlightCheckBox"
        Me.LCDlightCheckBox.Size = New System.Drawing.Size(106, 24)
        Me.LCDlightCheckBox.TabIndex = 4
        Me.LCDlightCheckBox.Text = "LCD Light"
        Me.LCDlightCheckBox.UseVisualStyleBackColor = True
        '
        'ByteTrackBar
        '
        Me.ByteTrackBar.Location = New System.Drawing.Point(285, 169)
        Me.ByteTrackBar.Maximum = 255
        Me.ByteTrackBar.Name = "ByteTrackBar"
        Me.ByteTrackBar.Size = New System.Drawing.Size(194, 69)
        Me.ByteTrackBar.TabIndex = 5
        '
        'ByteLabel
        '
        Me.ByteLabel.AutoSize = True
        Me.ByteLabel.Location = New System.Drawing.Point(368, 212)
        Me.ByteLabel.Name = "ByteLabel"
        Me.ByteLabel.Size = New System.Drawing.Size(24, 20)
        Me.ByteLabel.TabIndex = 6
        Me.ByteLabel.Text = "---"
        '
        'SendArrayButton
        '
        Me.SendArrayButton.Location = New System.Drawing.Point(40, 298)
        Me.SendArrayButton.Name = "SendArrayButton"
        Me.SendArrayButton.Size = New System.Drawing.Size(116, 71)
        Me.SendArrayButton.TabIndex = 9
        Me.SendArrayButton.Text = "Send Array 100,255,22"
        Me.SendArrayButton.UseVisualStyleBackColor = True
        '
        'StartButton
        '
        Me.StartButton.Location = New System.Drawing.Point(12, 12)
        Me.StartButton.Name = "StartButton"
        Me.StartButton.Size = New System.Drawing.Size(116, 53)
        Me.StartButton.TabIndex = 10
        Me.StartButton.Text = "Start USB Daemon"
        Me.StartButton.UseVisualStyleBackColor = True
        '
        'TerminateUSBButton
        '
        Me.TerminateUSBButton.Location = New System.Drawing.Point(134, 12)
        Me.TerminateUSBButton.Name = "TerminateUSBButton"
        Me.TerminateUSBButton.Size = New System.Drawing.Size(116, 53)
        Me.TerminateUSBButton.TabIndex = 11
        Me.TerminateUSBButton.Text = "Terminate USB Daemon"
        Me.TerminateUSBButton.UseVisualStyleBackColor = True
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(301, 136)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(154, 20)
        Me.Label2.TabIndex = 12
        Me.Label2.Text = "Slide to send 0 - 255"
        '
        'GetArrayButton
        '
        Me.GetArrayButton.Location = New System.Drawing.Point(162, 298)
        Me.GetArrayButton.Name = "GetArrayButton"
        Me.GetArrayButton.Size = New System.Drawing.Size(116, 71)
        Me.GetArrayButton.TabIndex = 13
        Me.GetArrayButton.Text = "Get Array"
        Me.GetArrayButton.UseVisualStyleBackColor = True
        '
        'DaemonStatusRadioButton
        '
        Me.DaemonStatusRadioButton.AutoSize = True
        Me.DaemonStatusRadioButton.Location = New System.Drawing.Point(295, 26)
        Me.DaemonStatusRadioButton.Name = "DaemonStatusRadioButton"
        Me.DaemonStatusRadioButton.Size = New System.Drawing.Size(184, 24)
        Me.DaemonStatusRadioButton.TabIndex = 14
        Me.DaemonStatusRadioButton.TabStop = True
        Me.DaemonStatusRadioButton.Text = "USB Daemon Status"
        Me.DaemonStatusRadioButton.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(506, 452)
        Me.Controls.Add(Me.DaemonStatusRadioButton)
        Me.Controls.Add(Me.GetArrayButton)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.TerminateUSBButton)
        Me.Controls.Add(Me.StartButton)
        Me.Controls.Add(Me.SendArrayButton)
        Me.Controls.Add(Me.ByteLabel)
        Me.Controls.Add(Me.ByteTrackBar)
        Me.Controls.Add(Me.LCDlightCheckBox)
        Me.Controls.Add(Me.PORTaLabel)
        Me.Controls.Add(Me.GetStatusButton)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.HelloButton)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "Form1"
        Me.Text = "USB Test"
        CType(Me.ByteTrackBar, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents HelloButton As Button
    Friend WithEvents Label1 As Label
    Friend WithEvents TimerDeviceConnection As Timer
    Friend WithEvents GetStatusButton As Button
    Friend WithEvents PORTaLabel As Label
    Friend WithEvents LCDlightCheckBox As CheckBox
    Friend WithEvents ByteTrackBar As TrackBar
    Friend WithEvents ByteLabel As Label
    Friend WithEvents SendArrayButton As Button
    Friend WithEvents StartButton As Button
    Friend WithEvents TerminateUSBButton As Button
    Friend WithEvents Label2 As Label
    Friend WithEvents GetArrayButton As Button
    Friend WithEvents DaemonStatusRadioButton As RadioButton
End Class
