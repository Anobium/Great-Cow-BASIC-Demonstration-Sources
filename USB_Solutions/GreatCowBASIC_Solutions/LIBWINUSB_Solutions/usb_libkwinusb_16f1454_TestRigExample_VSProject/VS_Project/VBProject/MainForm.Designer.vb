'
' Created by SharpDevelop.
' User: admin
' Date: 01/06/2018
' Time: 20:17
' 
' To change this template use Tools | Options | Coding | Edit Standard Headers.
'
Partial Class MainForm
    Inherits System.Windows.Forms.Form

    ''' <summary>
    ''' Designer variable used to keep track of non-visual components.
    ''' </summary>
    Private components As System.ComponentModel.IContainer

    ''' <summary>
    ''' Disposes resources used by the form.
    ''' </summary>
    ''' <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If components IsNot Nothing Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    ''' <summary>
    ''' This method is required for Windows Forms designer support.
    ''' Do not change the method contents inside the source code editor. The Forms designer might
    ''' not be able to load this method if it was changed manually.
    ''' </summary>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MainForm))
        Me.groupBox1 = New System.Windows.Forms.GroupBox()
        Me.ConnectionStatus = New System.Windows.Forms.Label()
        Me.groupBox2 = New System.Windows.Forms.GroupBox()
        Me.PollValues = New System.Windows.Forms.Button()
        Me.IO4Value = New System.Windows.Forms.TextBox()
        Me.label4 = New System.Windows.Forms.Label()
        Me.IO3Value = New System.Windows.Forms.TextBox()
        Me.label3 = New System.Windows.Forms.Label()
        Me.IO2Value = New System.Windows.Forms.TextBox()
        Me.label2 = New System.Windows.Forms.Label()
        Me.IO1Value = New System.Windows.Forms.TextBox()
        Me.label1 = New System.Windows.Forms.Label()
        Me.groupBox3 = New System.Windows.Forms.GroupBox()
        Me.BlackLED3 = New System.Windows.Forms.PictureBox()
        Me.BlackLED2 = New System.Windows.Forms.PictureBox()
        Me.GreenLED = New System.Windows.Forms.PictureBox()
        Me.SetLEDStatus2 = New System.Windows.Forms.CheckBox()
        Me.YellowLED = New System.Windows.Forms.PictureBox()
        Me.SetLEDStatus1 = New System.Windows.Forms.CheckBox()
        Me.BlackLED1 = New System.Windows.Forms.PictureBox()
        Me.RedLED = New System.Windows.Forms.PictureBox()
        Me.SetLEDStatus3 = New System.Windows.Forms.CheckBox()
        Me.footerRightText = New System.Windows.Forms.Label()
        Me.textBox1 = New System.Windows.Forms.TextBox()
        Me.VenPidText = New System.Windows.Forms.Label()
        Me.notifyIcon1 = New System.Windows.Forms.NotifyIcon(Me.components)
        Me.groupBox1.SuspendLayout()
        Me.groupBox2.SuspendLayout()
        Me.groupBox3.SuspendLayout()
        CType(Me.BlackLED3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BlackLED2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GreenLED, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.YellowLED, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.BlackLED1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.RedLED, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'groupBox1
        '
        Me.groupBox1.Controls.Add(Me.ConnectionStatus)
        Me.groupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox1.Location = New System.Drawing.Point(12, 12)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(168, 67)
        Me.groupBox1.TabIndex = 6
        Me.groupBox1.TabStop = False
        Me.groupBox1.Text = "USB Connection Status"
        '
        'ConnectionStatus
        '
        Me.ConnectionStatus.BackColor = System.Drawing.Color.Red
        Me.ConnectionStatus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ConnectionStatus.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ConnectionStatus.Location = New System.Drawing.Point(16, 24)
        Me.ConnectionStatus.Name = "ConnectionStatus"
        Me.ConnectionStatus.Size = New System.Drawing.Size(144, 26)
        Me.ConnectionStatus.TabIndex = 0
        Me.ConnectionStatus.Text = "USB device not connected"
        Me.ConnectionStatus.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'groupBox2
        '
        Me.groupBox2.Controls.Add(Me.PollValues)
        Me.groupBox2.Controls.Add(Me.IO4Value)
        Me.groupBox2.Controls.Add(Me.label4)
        Me.groupBox2.Controls.Add(Me.IO3Value)
        Me.groupBox2.Controls.Add(Me.label3)
        Me.groupBox2.Controls.Add(Me.IO2Value)
        Me.groupBox2.Controls.Add(Me.label2)
        Me.groupBox2.Controls.Add(Me.IO1Value)
        Me.groupBox2.Controls.Add(Me.label1)
        Me.groupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox2.Location = New System.Drawing.Point(12, 85)
        Me.groupBox2.Name = "groupBox2"
        Me.groupBox2.Size = New System.Drawing.Size(168, 163)
        Me.groupBox2.TabIndex = 7
        Me.groupBox2.TabStop = False
        Me.groupBox2.Text = "Input Port State"
        '
        'PollValues
        '
        Me.PollValues.Enabled = False
        Me.PollValues.Location = New System.Drawing.Point(22, 129)
        Me.PollValues.Name = "PollValues"
        Me.PollValues.Size = New System.Drawing.Size(128, 24)
        Me.PollValues.TabIndex = 9
        Me.PollValues.Text = "Read"
        Me.PollValues.UseVisualStyleBackColor = True
        '
        'IO4Value
        '
        Me.IO4Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO4Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO4Value.Location = New System.Drawing.Point(74, 105)
        Me.IO4Value.Name = "IO4Value"
        Me.IO4Value.ReadOnly = True
        Me.IO4Value.Size = New System.Drawing.Size(72, 13)
        Me.IO4Value.TabIndex = 7
        Me.IO4Value.Text = "0"
        Me.IO4Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label4
        '
        Me.label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label4.Location = New System.Drawing.Point(19, 105)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(100, 15)
        Me.label4.TabIndex = 6
        Me.label4.Text = "I/O 8"
        '
        'IO3Value
        '
        Me.IO3Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO3Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO3Value.Location = New System.Drawing.Point(74, 79)
        Me.IO3Value.Name = "IO3Value"
        Me.IO3Value.ReadOnly = True
        Me.IO3Value.Size = New System.Drawing.Size(72, 13)
        Me.IO3Value.TabIndex = 5
        Me.IO3Value.Text = "0"
        Me.IO3Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label3
        '
        Me.label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label3.Location = New System.Drawing.Point(19, 79)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(100, 15)
        Me.label3.TabIndex = 4
        Me.label3.Text = "I/O 7"
        '
        'IO2Value
        '
        Me.IO2Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO2Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO2Value.Location = New System.Drawing.Point(74, 54)
        Me.IO2Value.Name = "IO2Value"
        Me.IO2Value.ReadOnly = True
        Me.IO2Value.Size = New System.Drawing.Size(72, 13)
        Me.IO2Value.TabIndex = 3
        Me.IO2Value.Text = "0"
        Me.IO2Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label2
        '
        Me.label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label2.Location = New System.Drawing.Point(19, 54)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(100, 15)
        Me.label2.TabIndex = 2
        Me.label2.Text = "I/O 6"
        '
        'IO1Value
        '
        Me.IO1Value.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.IO1Value.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.IO1Value.Location = New System.Drawing.Point(74, 28)
        Me.IO1Value.Name = "IO1Value"
        Me.IO1Value.ReadOnly = True
        Me.IO1Value.Size = New System.Drawing.Size(72, 13)
        Me.IO1Value.TabIndex = 1
        Me.IO1Value.Text = "0"
        Me.IO1Value.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'label1
        '
        Me.label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.label1.Location = New System.Drawing.Point(19, 28)
        Me.label1.Margin = New System.Windows.Forms.Padding(3, 0, 0, 0)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(100, 15)
        Me.label1.TabIndex = 0
        Me.label1.Text = "I/O 5"
        '
        'groupBox3
        '
        Me.groupBox3.Controls.Add(Me.BlackLED3)
        Me.groupBox3.Controls.Add(Me.BlackLED2)
        Me.groupBox3.Controls.Add(Me.GreenLED)
        Me.groupBox3.Controls.Add(Me.SetLEDStatus2)
        Me.groupBox3.Controls.Add(Me.YellowLED)
        Me.groupBox3.Controls.Add(Me.SetLEDStatus1)
        Me.groupBox3.Controls.Add(Me.BlackLED1)
        Me.groupBox3.Controls.Add(Me.RedLED)
        Me.groupBox3.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.groupBox3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.groupBox3.Location = New System.Drawing.Point(18, 254)
        Me.groupBox3.Name = "groupBox3"
        Me.groupBox3.Size = New System.Drawing.Size(162, 171)
        Me.groupBox3.TabIndex = 8
        Me.groupBox3.TabStop = False
        Me.groupBox3.Text = "LED Status"
        '
        'BlackLED3
        '
        Me.BlackLED3.Image = CType(resources.GetObject("BlackLED3.Image"), System.Drawing.Image)
        Me.BlackLED3.Location = New System.Drawing.Point(11, 128)
        Me.BlackLED3.Name = "BlackLED3"
        Me.BlackLED3.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED3.TabIndex = 4
        Me.BlackLED3.TabStop = False
        '
        'BlackLED2
        '
        Me.BlackLED2.Image = CType(resources.GetObject("BlackLED2.Image"), System.Drawing.Image)
        Me.BlackLED2.Location = New System.Drawing.Point(11, 82)
        Me.BlackLED2.Name = "BlackLED2"
        Me.BlackLED2.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED2.TabIndex = 11
        Me.BlackLED2.TabStop = False
        '
        'GreenLED
        '
        Me.GreenLED.Image = CType(resources.GetObject("GreenLED.Image"), System.Drawing.Image)
        Me.GreenLED.Location = New System.Drawing.Point(11, 128)
        Me.GreenLED.Name = "GreenLED"
        Me.GreenLED.Size = New System.Drawing.Size(24, 22)
        Me.GreenLED.TabIndex = 6
        Me.GreenLED.TabStop = False
        '
        'SetLEDStatus2
        '
        Me.SetLEDStatus2.Enabled = False
        Me.SetLEDStatus2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus2.Location = New System.Drawing.Point(47, 82)
        Me.SetLEDStatus2.Name = "SetLEDStatus2"
        Me.SetLEDStatus2.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus2.TabIndex = 5
        Me.SetLEDStatus2.Text = "Set State"
        Me.SetLEDStatus2.UseVisualStyleBackColor = True
        '
        'YellowLED
        '
        Me.YellowLED.Image = CType(resources.GetObject("YellowLED.Image"), System.Drawing.Image)
        Me.YellowLED.Location = New System.Drawing.Point(11, 82)
        Me.YellowLED.Name = "YellowLED"
        Me.YellowLED.Size = New System.Drawing.Size(24, 22)
        Me.YellowLED.TabIndex = 4
        Me.YellowLED.TabStop = False
        '
        'SetLEDStatus1
        '
        Me.SetLEDStatus1.Enabled = False
        Me.SetLEDStatus1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus1.Location = New System.Drawing.Point(47, 35)
        Me.SetLEDStatus1.Name = "SetLEDStatus1"
        Me.SetLEDStatus1.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus1.TabIndex = 3
        Me.SetLEDStatus1.Text = "Set State"
        Me.SetLEDStatus1.UseVisualStyleBackColor = True
        '
        'BlackLED1
        '
        Me.BlackLED1.Image = CType(resources.GetObject("BlackLED1.Image"), System.Drawing.Image)
        Me.BlackLED1.Location = New System.Drawing.Point(11, 35)
        Me.BlackLED1.Name = "BlackLED1"
        Me.BlackLED1.Size = New System.Drawing.Size(24, 22)
        Me.BlackLED1.TabIndex = 2
        Me.BlackLED1.TabStop = False
        '
        'RedLED
        '
        Me.RedLED.Image = CType(resources.GetObject("RedLED.Image"), System.Drawing.Image)
        Me.RedLED.Location = New System.Drawing.Point(11, 36)
        Me.RedLED.Name = "RedLED"
        Me.RedLED.Size = New System.Drawing.Size(24, 22)
        Me.RedLED.TabIndex = 1
        Me.RedLED.TabStop = False
        Me.RedLED.Visible = False
        '
        'SetLEDStatus3
        '
        Me.SetLEDStatus3.Enabled = False
        Me.SetLEDStatus3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SetLEDStatus3.Location = New System.Drawing.Point(65, 382)
        Me.SetLEDStatus3.Name = "SetLEDStatus3"
        Me.SetLEDStatus3.Size = New System.Drawing.Size(71, 24)
        Me.SetLEDStatus3.TabIndex = 5
        Me.SetLEDStatus3.Text = "Set State"
        Me.SetLEDStatus3.UseVisualStyleBackColor = True
        '
        'footerRightText
        '
        Me.footerRightText.Location = New System.Drawing.Point(319, 451)
        Me.footerRightText.Name = "footerRightText"
        Me.footerRightText.Size = New System.Drawing.Size(72, 19)
        Me.footerRightText.TabIndex = 9
        Me.footerRightText.Text = "v1.0.0"
        Me.footerRightText.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'textBox1
        '
        Me.textBox1.Location = New System.Drawing.Point(188, 17)
        Me.textBox1.Multiline = True
        Me.textBox1.Name = "textBox1"
        Me.textBox1.ReadOnly = True
        Me.textBox1.Size = New System.Drawing.Size(203, 443)
        Me.textBox1.TabIndex = 10
        Me.textBox1.Text = resources.GetString("textBox1.Text")
        '
        'VenPidText
        '
        Me.VenPidText.Location = New System.Drawing.Point(15, 451)
        Me.VenPidText.Name = "VenPidText"
        Me.VenPidText.Size = New System.Drawing.Size(274, 19)
        Me.VenPidText.TabIndex = 9
        Me.VenPidText.Text = "Initialising ..."
        Me.VenPidText.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'notifyIcon1
        '
        Me.notifyIcon1.Text = "notifyIcon1"
        Me.notifyIcon1.Visible = True
        '
        'MainForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(407, 472)
        Me.Controls.Add(Me.footerRightText)
        Me.Controls.Add(Me.SetLEDStatus3)
        Me.Controls.Add(Me.textBox1)
        Me.Controls.Add(Me.VenPidText)
        Me.Controls.Add(Me.groupBox3)
        Me.Controls.Add(Me.groupBox2)
        Me.Controls.Add(Me.groupBox1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "MainForm"
        Me.Text = "16F1454 USB Test Rig Utility"
        Me.groupBox1.ResumeLayout(False)
        Me.groupBox2.ResumeLayout(False)
        Me.groupBox2.PerformLayout()
        Me.groupBox3.ResumeLayout(False)
        CType(Me.BlackLED3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BlackLED2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GreenLED, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.YellowLED, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.BlackLED1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.RedLED, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Private BlackLED1 As System.Windows.Forms.PictureBox
    Private RedLED As System.Windows.Forms.PictureBox
    Private notifyIcon1 As System.Windows.Forms.NotifyIcon
    Private VenPidText As System.Windows.Forms.Label
    Private textBox1 As System.Windows.Forms.TextBox
    Private ConnectionStatus As System.Windows.Forms.Label
    Private footerRightText As System.Windows.Forms.Label
    Private groupBox3 As System.Windows.Forms.GroupBox
    Private label2 As System.Windows.Forms.Label
    Private IO2Value As System.Windows.Forms.TextBox
    Private label3 As System.Windows.Forms.Label
    Private IO3Value As System.Windows.Forms.TextBox
    Private label4 As System.Windows.Forms.Label
    Private IO4Value As System.Windows.Forms.TextBox
    Private label1 As System.Windows.Forms.Label
    Private IO1Value As System.Windows.Forms.TextBox
    Private groupBox2 As System.Windows.Forms.GroupBox
    Private groupBox1 As System.Windows.Forms.GroupBox
    Private WithEvents PollValues As Button
    Private WithEvents SetLEDStatus1 As CheckBox
    Private WithEvents GreenLED As PictureBox
    Private WithEvents SetLEDStatus3 As CheckBox
    Private WithEvents BlackLED3 As PictureBox

    Sub FooterRightTextClick(sender As Object, e As EventArgs)

    End Sub

    Private WithEvents SetLEDStatus2 As CheckBox
    Private WithEvents YellowLED As PictureBox
    Private WithEvents BlackLED2 As PictureBox
End Class
