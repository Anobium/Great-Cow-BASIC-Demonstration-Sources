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
        Me.SuspendLayout()
        '
        'HelloButton
        '
        Me.HelloButton.Location = New System.Drawing.Point(158, 156)
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
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(506, 452)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.HelloButton)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "Form1"
        Me.Text = "USB Test"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents HelloButton As Button
    Friend WithEvents Label1 As Label
    Friend WithEvents TimerDeviceConnection As Timer
End Class
