
namespace Tool32
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.toolMode = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.sndBox = new System.Windows.Forms.GroupBox();
            this.hexData7 = new System.Windows.Forms.Label();
            this.hexData6 = new System.Windows.Forms.Label();
            this.hexData5 = new System.Windows.Forms.Label();
            this.hexData4 = new System.Windows.Forms.Label();
            this.hexData3 = new System.Windows.Forms.Label();
            this.hexData2 = new System.Windows.Forms.Label();
            this.hexData1 = new System.Windows.Forms.Label();
            this.hexData0 = new System.Windows.Forms.Label();
            this.hexDLC = new System.Windows.Forms.Label();
            this.hexID = new System.Windows.Forms.Label();
            this.sndData7 = new System.Windows.Forms.NumericUpDown();
            this.TransmitBtn = new System.Windows.Forms.Button();
            this.sndData6 = new System.Windows.Forms.NumericUpDown();
            this.label11 = new System.Windows.Forms.Label();
            this.sndData5 = new System.Windows.Forms.NumericUpDown();
            this.label10 = new System.Windows.Forms.Label();
            this.sndData4 = new System.Windows.Forms.NumericUpDown();
            this.label9 = new System.Windows.Forms.Label();
            this.sndData3 = new System.Windows.Forms.NumericUpDown();
            this.label8 = new System.Windows.Forms.Label();
            this.sndData2 = new System.Windows.Forms.NumericUpDown();
            this.label7 = new System.Windows.Forms.Label();
            this.sndData1 = new System.Windows.Forms.NumericUpDown();
            this.label6 = new System.Windows.Forms.Label();
            this.sndData0 = new System.Windows.Forms.NumericUpDown();
            this.label5 = new System.Windows.Forms.Label();
            this.sndDLC = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.sndID = new System.Windows.Forms.NumericUpDown();
            this.label3 = new System.Windows.Forms.Label();
            this.sndIDE = new System.Windows.Forms.RadioButton();
            this.sndRTR = new System.Windows.Forms.CheckBox();
            this.sndForce = new System.Windows.Forms.CheckBox();
            this.label2 = new System.Windows.Forms.Label();
            this.readGridView = new System.Windows.Forms.DataGridView();
            this.TimeStamp = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColIDE = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.Dir = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColRTR = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.ColDLC = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData0 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData4 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData5 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData6 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ColData7 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.DeviceStatus = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.DeviceTimer = new System.Windows.Forms.Timer(this.components);
            this.CanFPS = new System.Windows.Forms.Timer(this.components);
            this.RxBtn = new System.Windows.Forms.Button();
            this.label12 = new System.Windows.Forms.Label();
            this.saveBtn = new System.Windows.Forms.Button();
            this.ClearBtn = new System.Windows.Forms.Button();
            this.BitRate = new System.Windows.Forms.ComboBox();
            this.label13 = new System.Windows.Forms.Label();
            this.NumMask = new System.Windows.Forms.NumericUpDown();
            this.NumFilter = new System.Windows.Forms.NumericUpDown();
            this.FilterMode = new System.Windows.Forms.ComboBox();
            this.label14 = new System.Windows.Forms.Label();
            this.label15 = new System.Windows.Forms.Label();
            this.hexMask = new System.Windows.Forms.Label();
            this.hexFilter = new System.Windows.Forms.Label();
            this.filForce = new System.Windows.Forms.CheckBox();
            this.CanRxWorker = new System.ComponentModel.BackgroundWorker();
            this.sndBox.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.sndData7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData0)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndDLC)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndID)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.readGridView)).BeginInit();
            this.statusStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.NumMask)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.NumFilter)).BeginInit();
            this.SuspendLayout();
            // 
            // toolMode
            // 
            this.toolMode.FormattingEnabled = true;
            this.toolMode.Items.AddRange(new object[] {
            "Listen",
            "Normal"});
            this.toolMode.Location = new System.Drawing.Point(18, 63);
            this.toolMode.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.toolMode.Name = "toolMode";
            this.toolMode.Size = new System.Drawing.Size(180, 28);
            this.toolMode.TabIndex = 0;
            this.toolMode.Text = "Listen";
            this.toolMode.SelectedIndexChanged += new System.EventHandler(this.toolMode_SelectedIndexChanged);
            this.toolMode.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.toolMode_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(18, 38);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(120, 20);
            this.label1.TabIndex = 1;
            this.label1.Text = "Tool CAN Mode";
            // 
            // sndBox
            // 
            this.sndBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.sndBox.Controls.Add(this.hexData7);
            this.sndBox.Controls.Add(this.hexData6);
            this.sndBox.Controls.Add(this.hexData5);
            this.sndBox.Controls.Add(this.hexData4);
            this.sndBox.Controls.Add(this.hexData3);
            this.sndBox.Controls.Add(this.hexData2);
            this.sndBox.Controls.Add(this.hexData1);
            this.sndBox.Controls.Add(this.hexData0);
            this.sndBox.Controls.Add(this.hexDLC);
            this.sndBox.Controls.Add(this.hexID);
            this.sndBox.Controls.Add(this.sndData7);
            this.sndBox.Controls.Add(this.TransmitBtn);
            this.sndBox.Controls.Add(this.sndData6);
            this.sndBox.Controls.Add(this.label11);
            this.sndBox.Controls.Add(this.sndData5);
            this.sndBox.Controls.Add(this.label10);
            this.sndBox.Controls.Add(this.sndData4);
            this.sndBox.Controls.Add(this.label9);
            this.sndBox.Controls.Add(this.sndData3);
            this.sndBox.Controls.Add(this.label8);
            this.sndBox.Controls.Add(this.sndData2);
            this.sndBox.Controls.Add(this.label7);
            this.sndBox.Controls.Add(this.sndData1);
            this.sndBox.Controls.Add(this.label6);
            this.sndBox.Controls.Add(this.sndData0);
            this.sndBox.Controls.Add(this.label5);
            this.sndBox.Controls.Add(this.sndDLC);
            this.sndBox.Controls.Add(this.label4);
            this.sndBox.Controls.Add(this.sndID);
            this.sndBox.Controls.Add(this.label3);
            this.sndBox.Controls.Add(this.sndIDE);
            this.sndBox.Controls.Add(this.sndRTR);
            this.sndBox.Controls.Add(this.sndForce);
            this.sndBox.Controls.Add(this.label2);
            this.sndBox.Enabled = false;
            this.sndBox.Location = new System.Drawing.Point(250, 43);
            this.sndBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndBox.Name = "sndBox";
            this.sndBox.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndBox.Size = new System.Drawing.Size(1184, 125);
            this.sndBox.TabIndex = 2;
            this.sndBox.TabStop = false;
            this.sndBox.Text = "Arguments";
            // 
            // hexData7
            // 
            this.hexData7.AutoSize = true;
            this.hexData7.Location = new System.Drawing.Point(984, 89);
            this.hexData7.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData7.Name = "hexData7";
            this.hexData7.Size = new System.Drawing.Size(27, 20);
            this.hexData7.TabIndex = 34;
            this.hexData7.Text = "00";
            // 
            // hexData6
            // 
            this.hexData6.AutoSize = true;
            this.hexData6.Location = new System.Drawing.Point(915, 89);
            this.hexData6.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData6.Name = "hexData6";
            this.hexData6.Size = new System.Drawing.Size(27, 20);
            this.hexData6.TabIndex = 33;
            this.hexData6.Text = "00";
            // 
            // hexData5
            // 
            this.hexData5.AutoSize = true;
            this.hexData5.Location = new System.Drawing.Point(846, 89);
            this.hexData5.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData5.Name = "hexData5";
            this.hexData5.Size = new System.Drawing.Size(27, 20);
            this.hexData5.TabIndex = 32;
            this.hexData5.Text = "00";
            // 
            // hexData4
            // 
            this.hexData4.AutoSize = true;
            this.hexData4.Location = new System.Drawing.Point(777, 89);
            this.hexData4.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData4.Name = "hexData4";
            this.hexData4.Size = new System.Drawing.Size(27, 20);
            this.hexData4.TabIndex = 31;
            this.hexData4.Text = "00";
            // 
            // hexData3
            // 
            this.hexData3.AutoSize = true;
            this.hexData3.Location = new System.Drawing.Point(708, 89);
            this.hexData3.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData3.Name = "hexData3";
            this.hexData3.Size = new System.Drawing.Size(27, 20);
            this.hexData3.TabIndex = 30;
            this.hexData3.Text = "00";
            // 
            // hexData2
            // 
            this.hexData2.AutoSize = true;
            this.hexData2.Location = new System.Drawing.Point(640, 89);
            this.hexData2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData2.Name = "hexData2";
            this.hexData2.Size = new System.Drawing.Size(27, 20);
            this.hexData2.TabIndex = 29;
            this.hexData2.Text = "00";
            // 
            // hexData1
            // 
            this.hexData1.AutoSize = true;
            this.hexData1.Location = new System.Drawing.Point(570, 89);
            this.hexData1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData1.Name = "hexData1";
            this.hexData1.Size = new System.Drawing.Size(27, 20);
            this.hexData1.TabIndex = 28;
            this.hexData1.Text = "00";
            // 
            // hexData0
            // 
            this.hexData0.AutoSize = true;
            this.hexData0.Location = new System.Drawing.Point(501, 89);
            this.hexData0.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexData0.Name = "hexData0";
            this.hexData0.Size = new System.Drawing.Size(27, 20);
            this.hexData0.TabIndex = 27;
            this.hexData0.Text = "00";
            // 
            // hexDLC
            // 
            this.hexDLC.AutoSize = true;
            this.hexDLC.Location = new System.Drawing.Point(406, 89);
            this.hexDLC.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexDLC.Name = "hexDLC";
            this.hexDLC.Size = new System.Drawing.Size(27, 20);
            this.hexDLC.TabIndex = 26;
            this.hexDLC.Text = "01";
            // 
            // hexID
            // 
            this.hexID.AutoSize = true;
            this.hexID.Location = new System.Drawing.Point(90, 89);
            this.hexID.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexID.Name = "hexID";
            this.hexID.Size = new System.Drawing.Size(18, 20);
            this.hexID.TabIndex = 25;
            this.hexID.Text = "0";
            // 
            // sndData7
            // 
            this.sndData7.Enabled = false;
            this.sndData7.Location = new System.Drawing.Point(982, 51);
            this.sndData7.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData7.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData7.Name = "sndData7";
            this.sndData7.Size = new System.Drawing.Size(60, 26);
            this.sndData7.TabIndex = 12;
            this.sndData7.ValueChanged += new System.EventHandler(this.sndData7_ValueChanged);
            // 
            // TransmitBtn
            // 
            this.TransmitBtn.Location = new System.Drawing.Point(1052, 31);
            this.TransmitBtn.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.TransmitBtn.Name = "TransmitBtn";
            this.TransmitBtn.Size = new System.Drawing.Size(112, 68);
            this.TransmitBtn.TabIndex = 24;
            this.TransmitBtn.Text = "Transmit";
            this.TransmitBtn.UseVisualStyleBackColor = true;
            this.TransmitBtn.Click += new System.EventHandler(this.TransmitBtn_Click);
            // 
            // sndData6
            // 
            this.sndData6.Enabled = false;
            this.sndData6.Location = new System.Drawing.Point(914, 51);
            this.sndData6.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData6.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData6.Name = "sndData6";
            this.sndData6.Size = new System.Drawing.Size(60, 26);
            this.sndData6.TabIndex = 11;
            this.sndData6.ValueChanged += new System.EventHandler(this.sndData6_ValueChanged);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(984, 22);
            this.label11.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(57, 20);
            this.label11.TabIndex = 23;
            this.label11.Text = "Data7 ";
            // 
            // sndData5
            // 
            this.sndData5.Enabled = false;
            this.sndData5.Location = new System.Drawing.Point(844, 51);
            this.sndData5.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData5.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData5.Name = "sndData5";
            this.sndData5.Size = new System.Drawing.Size(60, 26);
            this.sndData5.TabIndex = 10;
            this.sndData5.ValueChanged += new System.EventHandler(this.sndData5_ValueChanged);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(915, 22);
            this.label10.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(57, 20);
            this.label10.TabIndex = 21;
            this.label10.Text = "Data6 ";
            // 
            // sndData4
            // 
            this.sndData4.Enabled = false;
            this.sndData4.Location = new System.Drawing.Point(776, 51);
            this.sndData4.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData4.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData4.Name = "sndData4";
            this.sndData4.Size = new System.Drawing.Size(60, 26);
            this.sndData4.TabIndex = 9;
            this.sndData4.ValueChanged += new System.EventHandler(this.sndData4_ValueChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(846, 22);
            this.label9.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(57, 20);
            this.label9.TabIndex = 19;
            this.label9.Text = "Data5 ";
            // 
            // sndData3
            // 
            this.sndData3.Enabled = false;
            this.sndData3.Location = new System.Drawing.Point(706, 51);
            this.sndData3.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData3.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData3.Name = "sndData3";
            this.sndData3.Size = new System.Drawing.Size(60, 26);
            this.sndData3.TabIndex = 8;
            this.sndData3.ValueChanged += new System.EventHandler(this.sndData3_ValueChanged);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(777, 22);
            this.label8.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(57, 20);
            this.label8.TabIndex = 17;
            this.label8.Text = "Data4 ";
            // 
            // sndData2
            // 
            this.sndData2.Enabled = false;
            this.sndData2.Location = new System.Drawing.Point(638, 51);
            this.sndData2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData2.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData2.Name = "sndData2";
            this.sndData2.Size = new System.Drawing.Size(60, 26);
            this.sndData2.TabIndex = 7;
            this.sndData2.ValueChanged += new System.EventHandler(this.sndData2_ValueChanged);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(708, 22);
            this.label7.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(57, 20);
            this.label7.TabIndex = 15;
            this.label7.Text = "Data3 ";
            // 
            // sndData1
            // 
            this.sndData1.Enabled = false;
            this.sndData1.Location = new System.Drawing.Point(568, 51);
            this.sndData1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData1.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData1.Name = "sndData1";
            this.sndData1.Size = new System.Drawing.Size(60, 26);
            this.sndData1.TabIndex = 6;
            this.sndData1.ValueChanged += new System.EventHandler(this.sndData1_ValueChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(640, 22);
            this.label6.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(57, 20);
            this.label6.TabIndex = 13;
            this.label6.Text = "Data2 ";
            // 
            // sndData0
            // 
            this.sndData0.Location = new System.Drawing.Point(500, 51);
            this.sndData0.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndData0.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.sndData0.Name = "sndData0";
            this.sndData0.Size = new System.Drawing.Size(60, 26);
            this.sndData0.TabIndex = 5;
            this.sndData0.ValueChanged += new System.EventHandler(this.sndData0_ValueChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(570, 22);
            this.label5.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(57, 20);
            this.label5.TabIndex = 11;
            this.label5.Text = "Data1 ";
            // 
            // sndDLC
            // 
            this.sndDLC.Location = new System.Drawing.Point(398, 51);
            this.sndDLC.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndDLC.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.sndDLC.Name = "sndDLC";
            this.sndDLC.Size = new System.Drawing.Size(60, 26);
            this.sndDLC.TabIndex = 4;
            this.sndDLC.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.sndDLC.ValueChanged += new System.EventHandler(this.sndDLC_ValueChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(501, 22);
            this.label4.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(57, 20);
            this.label4.TabIndex = 9;
            this.label4.Text = "Data0 ";
            // 
            // sndID
            // 
            this.sndID.Location = new System.Drawing.Point(16, 51);
            this.sndID.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndID.Maximum = new decimal(new int[] {
            536870911,
            0,
            0,
            0});
            this.sndID.Name = "sndID";
            this.sndID.Size = new System.Drawing.Size(180, 26);
            this.sndID.TabIndex = 3;
            this.sndID.ValueChanged += new System.EventHandler(this.sndID_ValueChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(406, 22);
            this.label3.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(49, 20);
            this.label3.TabIndex = 7;
            this.label3.Text = "DLC  ";
            // 
            // sndIDE
            // 
            this.sndIDE.AutoSize = true;
            this.sndIDE.Location = new System.Drawing.Point(310, 52);
            this.sndIDE.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndIDE.Name = "sndIDE";
            this.sndIDE.Size = new System.Drawing.Size(62, 24);
            this.sndIDE.TabIndex = 6;
            this.sndIDE.TabStop = true;
            this.sndIDE.Text = "IDE";
            this.sndIDE.UseVisualStyleBackColor = true;
            this.sndIDE.CheckedChanged += new System.EventHandler(this.sndIDE_CheckedChanged);
            // 
            // sndRTR
            // 
            this.sndRTR.AutoSize = true;
            this.sndRTR.Location = new System.Drawing.Point(220, 54);
            this.sndRTR.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndRTR.Name = "sndRTR";
            this.sndRTR.Size = new System.Drawing.Size(68, 24);
            this.sndRTR.TabIndex = 4;
            this.sndRTR.Text = "RTR";
            this.sndRTR.UseVisualStyleBackColor = true;
            this.sndRTR.CheckedChanged += new System.EventHandler(this.checkBox2_CheckedChanged);
            // 
            // sndForce
            // 
            this.sndForce.AutoSize = true;
            this.sndForce.Location = new System.Drawing.Point(220, 89);
            this.sndForce.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.sndForce.Name = "sndForce";
            this.sndForce.Size = new System.Drawing.Size(169, 24);
            this.sndForce.TabIndex = 3;
            this.sndForce.Text = "Force Extended ID";
            this.sndForce.UseVisualStyleBackColor = true;
            this.sndForce.CheckedChanged += new System.EventHandler(this.sndForce_CheckedChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(90, 25);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(26, 20);
            this.label2.TabIndex = 2;
            this.label2.Text = "ID";
            // 
            // readGridView
            // 
            this.readGridView.AllowUserToAddRows = false;
            this.readGridView.AllowUserToDeleteRows = false;
            this.readGridView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.readGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.readGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.TimeStamp,
            this.ColID,
            this.ColIDE,
            this.Dir,
            this.ColRTR,
            this.ColDLC,
            this.ColData0,
            this.ColData1,
            this.ColData2,
            this.ColData3,
            this.ColData4,
            this.ColData5,
            this.ColData6,
            this.ColData7});
            this.readGridView.Location = new System.Drawing.Point(9, 274);
            this.readGridView.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.readGridView.Name = "readGridView";
            this.readGridView.ReadOnly = true;
            this.readGridView.RowHeadersWidth = 62;
            this.readGridView.Size = new System.Drawing.Size(1458, 705);
            this.readGridView.TabIndex = 3;
            // 
            // TimeStamp
            // 
            this.TimeStamp.HeaderText = "Time Stamp";
            this.TimeStamp.MinimumWidth = 8;
            this.TimeStamp.Name = "TimeStamp";
            this.TimeStamp.ReadOnly = true;
            this.TimeStamp.Width = 150;
            // 
            // ColID
            // 
            this.ColID.HeaderText = "ID";
            this.ColID.MinimumWidth = 8;
            this.ColID.Name = "ColID";
            this.ColID.ReadOnly = true;
            this.ColID.Width = 150;
            // 
            // ColIDE
            // 
            this.ColIDE.HeaderText = "IDE";
            this.ColIDE.MinimumWidth = 8;
            this.ColIDE.Name = "ColIDE";
            this.ColIDE.ReadOnly = true;
            this.ColIDE.Width = 50;
            // 
            // Dir
            // 
            this.Dir.HeaderText = "Dir";
            this.Dir.MinimumWidth = 8;
            this.Dir.Name = "Dir";
            this.Dir.ReadOnly = true;
            this.Dir.Width = 50;
            // 
            // ColRTR
            // 
            this.ColRTR.HeaderText = "RTR";
            this.ColRTR.MinimumWidth = 8;
            this.ColRTR.Name = "ColRTR";
            this.ColRTR.ReadOnly = true;
            this.ColRTR.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.ColRTR.Width = 50;
            // 
            // ColDLC
            // 
            this.ColDLC.HeaderText = "DLC";
            this.ColDLC.MinimumWidth = 8;
            this.ColDLC.Name = "ColDLC";
            this.ColDLC.ReadOnly = true;
            this.ColDLC.Width = 50;
            // 
            // ColData0
            // 
            this.ColData0.HeaderText = "Data0";
            this.ColData0.MinimumWidth = 8;
            this.ColData0.Name = "ColData0";
            this.ColData0.ReadOnly = true;
            this.ColData0.Width = 50;
            // 
            // ColData1
            // 
            this.ColData1.HeaderText = "Data1";
            this.ColData1.MinimumWidth = 8;
            this.ColData1.Name = "ColData1";
            this.ColData1.ReadOnly = true;
            this.ColData1.Width = 50;
            // 
            // ColData2
            // 
            this.ColData2.HeaderText = "Data2";
            this.ColData2.MinimumWidth = 8;
            this.ColData2.Name = "ColData2";
            this.ColData2.ReadOnly = true;
            this.ColData2.Width = 50;
            // 
            // ColData3
            // 
            this.ColData3.HeaderText = "Data3";
            this.ColData3.MinimumWidth = 8;
            this.ColData3.Name = "ColData3";
            this.ColData3.ReadOnly = true;
            this.ColData3.Width = 50;
            // 
            // ColData4
            // 
            this.ColData4.HeaderText = "Data4";
            this.ColData4.MinimumWidth = 8;
            this.ColData4.Name = "ColData4";
            this.ColData4.ReadOnly = true;
            this.ColData4.Width = 50;
            // 
            // ColData5
            // 
            this.ColData5.HeaderText = "Data5";
            this.ColData5.MinimumWidth = 8;
            this.ColData5.Name = "ColData5";
            this.ColData5.ReadOnly = true;
            this.ColData5.Width = 50;
            // 
            // ColData6
            // 
            this.ColData6.HeaderText = "Data6";
            this.ColData6.MinimumWidth = 8;
            this.ColData6.Name = "ColData6";
            this.ColData6.ReadOnly = true;
            this.ColData6.Width = 50;
            // 
            // ColData7
            // 
            this.ColData7.HeaderText = "Data7";
            this.ColData7.MinimumWidth = 8;
            this.ColData7.Name = "ColData7";
            this.ColData7.ReadOnly = true;
            this.ColData7.Width = 50;
            // 
            // statusStrip1
            // 
            this.statusStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.DeviceStatus});
            this.statusStrip1.Location = new System.Drawing.Point(0, 985);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Padding = new System.Windows.Forms.Padding(2, 0, 21, 0);
            this.statusStrip1.Size = new System.Drawing.Size(1476, 32);
            this.statusStrip1.TabIndex = 4;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // DeviceStatus
            // 
            this.DeviceStatus.Name = "DeviceStatus";
            this.DeviceStatus.Size = new System.Drawing.Size(189, 25);
            this.DeviceStatus.Text = "Device Not Connected";
            // 
            // toolStrip1
            // 
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Padding = new System.Windows.Forms.Padding(0, 0, 3, 0);
            this.toolStrip1.Size = new System.Drawing.Size(1476, 25);
            this.toolStrip1.TabIndex = 5;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // DeviceTimer
            // 
            this.DeviceTimer.Enabled = true;
            this.DeviceTimer.Interval = 200;
            this.DeviceTimer.Tick += new System.EventHandler(this.DeviceTimer_Tick);
            // 
            // CanFPS
            // 
            this.CanFPS.Enabled = true;
            this.CanFPS.Interval = 1000;
            // 
            // RxBtn
            // 
            this.RxBtn.Location = new System.Drawing.Point(13, 214);
            this.RxBtn.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.RxBtn.Name = "RxBtn";
            this.RxBtn.Size = new System.Drawing.Size(86, 46);
            this.RxBtn.TabIndex = 6;
            this.RxBtn.Text = "Start";
            this.RxBtn.UseVisualStyleBackColor = true;
            this.RxBtn.Click += new System.EventHandler(this.RxButton_Click);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(18, 189);
            this.label12.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(161, 20);
            this.label12.TabIndex = 7;
            this.label12.Text = "CAN Frames Capture";
            // 
            // saveBtn
            // 
            this.saveBtn.Location = new System.Drawing.Point(107, 214);
            this.saveBtn.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.saveBtn.Name = "saveBtn";
            this.saveBtn.Size = new System.Drawing.Size(86, 46);
            this.saveBtn.TabIndex = 8;
            this.saveBtn.Text = "Save";
            this.saveBtn.UseVisualStyleBackColor = true;
            this.saveBtn.Click += new System.EventHandler(this.saveBtn_Click);
            // 
            // ClearBtn
            // 
            this.ClearBtn.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.ClearBtn.Location = new System.Drawing.Point(1381, 218);
            this.ClearBtn.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.ClearBtn.Name = "ClearBtn";
            this.ClearBtn.Size = new System.Drawing.Size(86, 46);
            this.ClearBtn.TabIndex = 9;
            this.ClearBtn.Text = "Clear";
            this.ClearBtn.UseVisualStyleBackColor = true;
            this.ClearBtn.Click += new System.EventHandler(this.ClearBtn_Click);
            // 
            // BitRate
            // 
            this.BitRate.FormattingEnabled = true;
            this.BitRate.Items.AddRange(new object[] {
            "5",
            "10",
            "20",
            "31.25",
            "33.3",
            "40",
            "50",
            "80",
            "100",
            "125",
            "200",
            "250",
            "500",
            "1000"});
            this.BitRate.Location = new System.Drawing.Point(18, 132);
            this.BitRate.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.BitRate.Name = "BitRate";
            this.BitRate.Size = new System.Drawing.Size(180, 28);
            this.BitRate.TabIndex = 36;
            this.BitRate.Text = "1000";
            this.BitRate.SelectedIndexChanged += new System.EventHandler(this.BitRate_SelectedIndexChanged);
            this.BitRate.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.BitRate_KeyPress);
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(18, 107);
            this.label13.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(144, 20);
            this.label13.TabIndex = 37;
            this.label13.Text = "CAN Bit Rate Kbps";
            // 
            // NumMask
            // 
            this.NumMask.Enabled = false;
            this.NumMask.Location = new System.Drawing.Point(668, 220);
            this.NumMask.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.NumMask.Maximum = new decimal(new int[] {
            536870911,
            0,
            0,
            0});
            this.NumMask.Name = "NumMask";
            this.NumMask.Size = new System.Drawing.Size(180, 26);
            this.NumMask.TabIndex = 38;
            this.NumMask.ValueChanged += new System.EventHandler(this.NumMask_ValueChanged);
            // 
            // NumFilter
            // 
            this.NumFilter.Enabled = false;
            this.NumFilter.Location = new System.Drawing.Point(911, 220);
            this.NumFilter.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.NumFilter.Maximum = new decimal(new int[] {
            536870911,
            0,
            0,
            0});
            this.NumFilter.Name = "NumFilter";
            this.NumFilter.Size = new System.Drawing.Size(180, 26);
            this.NumFilter.TabIndex = 39;
            this.NumFilter.ValueChanged += new System.EventHandler(this.NumFilter_ValueChanged);
            // 
            // FilterMode
            // 
            this.FilterMode.FormattingEnabled = true;
            this.FilterMode.Items.AddRange(new object[] {
            "Filter Off Allow All",
            "Filter On"});
            this.FilterMode.Location = new System.Drawing.Point(445, 218);
            this.FilterMode.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.FilterMode.Name = "FilterMode";
            this.FilterMode.Size = new System.Drawing.Size(160, 28);
            this.FilterMode.TabIndex = 40;
            this.FilterMode.Text = "Filter Off Allow All";
            this.FilterMode.SelectedIndexChanged += new System.EventHandler(this.FilterMode_SelectedIndexChanged);
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(613, 222);
            this.label14.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(47, 20);
            this.label14.TabIndex = 41;
            this.label14.Text = "Mask";
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Location = new System.Drawing.Point(856, 221);
            this.label15.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(44, 20);
            this.label15.TabIndex = 42;
            this.label15.Text = "Filter";
            // 
            // hexMask
            // 
            this.hexMask.AutoSize = true;
            this.hexMask.Location = new System.Drawing.Point(736, 251);
            this.hexMask.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexMask.Name = "hexMask";
            this.hexMask.Size = new System.Drawing.Size(34, 20);
            this.hexMask.TabIndex = 35;
            this.hexMask.Text = "0x0";
            // 
            // hexFilter
            // 
            this.hexFilter.AutoSize = true;
            this.hexFilter.Location = new System.Drawing.Point(981, 251);
            this.hexFilter.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.hexFilter.Name = "hexFilter";
            this.hexFilter.Size = new System.Drawing.Size(34, 20);
            this.hexFilter.TabIndex = 43;
            this.hexFilter.Text = "0x0";
            // 
            // filForce
            // 
            this.filForce.AutoSize = true;
            this.filForce.Location = new System.Drawing.Point(1100, 220);
            this.filForce.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.filForce.Name = "filForce";
            this.filForce.Size = new System.Drawing.Size(187, 24);
            this.filForce.TabIndex = 35;
            this.filForce.Text = "Force Extended Filter";
            this.filForce.UseVisualStyleBackColor = true;
            this.filForce.CheckedChanged += new System.EventHandler(this.filForce_CheckedChanged);
            // 
            // CanRxWorker
            // 
            this.CanRxWorker.WorkerSupportsCancellation = true;
            this.CanRxWorker.DoWork += new System.ComponentModel.DoWorkEventHandler(this.CanRxWorker_DoWork);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1476, 1017);
            this.Controls.Add(this.filForce);
            this.Controls.Add(this.hexFilter);
            this.Controls.Add(this.hexMask);
            this.Controls.Add(this.label15);
            this.Controls.Add(this.label14);
            this.Controls.Add(this.FilterMode);
            this.Controls.Add(this.NumFilter);
            this.Controls.Add(this.NumMask);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.BitRate);
            this.Controls.Add(this.ClearBtn);
            this.Controls.Add(this.saveBtn);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.RxBtn);
            this.Controls.Add(this.toolStrip1);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.readGridView);
            this.Controls.Add(this.sndBox);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.toolMode);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MinimumSize = new System.Drawing.Size(1489, 1047);
            this.Name = "Form1";
            this.Text = "Tool32                  Mier Engineering";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.sndBox.ResumeLayout(false);
            this.sndBox.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.sndData7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndData0)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndDLC)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sndID)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.readGridView)).EndInit();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.NumMask)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.NumFilter)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox toolMode;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox sndBox;
        private System.Windows.Forms.Button TransmitBtn;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.RadioButton sndIDE;
        private System.Windows.Forms.CheckBox sndRTR;
        private System.Windows.Forms.CheckBox sndForce;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.NumericUpDown sndID;
        private System.Windows.Forms.NumericUpDown sndDLC;
        private System.Windows.Forms.NumericUpDown sndData0;
        private System.Windows.Forms.NumericUpDown sndData1;
        private System.Windows.Forms.NumericUpDown sndData2;
        private System.Windows.Forms.NumericUpDown sndData3;
        private System.Windows.Forms.NumericUpDown sndData4;
        private System.Windows.Forms.NumericUpDown sndData5;
        private System.Windows.Forms.NumericUpDown sndData6;
        private System.Windows.Forms.NumericUpDown sndData7;
        private System.Windows.Forms.Label hexID;
        private System.Windows.Forms.Label hexData7;
        private System.Windows.Forms.Label hexData6;
        private System.Windows.Forms.Label hexData5;
        private System.Windows.Forms.Label hexData4;
        private System.Windows.Forms.Label hexData3;
        private System.Windows.Forms.Label hexData2;
        private System.Windows.Forms.Label hexData1;
        private System.Windows.Forms.Label hexData0;
        private System.Windows.Forms.Label hexDLC;
        private System.Windows.Forms.DataGridView readGridView;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel DeviceStatus;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.Timer DeviceTimer;
        private System.Windows.Forms.Timer CanFPS;
        private System.Windows.Forms.Button RxBtn;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Button saveBtn;
        private System.Windows.Forms.Button ClearBtn;
        private System.Windows.Forms.ComboBox BitRate;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.NumericUpDown NumMask;
        private System.Windows.Forms.NumericUpDown NumFilter;
        private System.Windows.Forms.ComboBox FilterMode;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.Label hexMask;
        private System.Windows.Forms.Label hexFilter;
        private System.Windows.Forms.CheckBox filForce;
        private System.Windows.Forms.DataGridViewTextBoxColumn TimeStamp;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColID;
        private System.Windows.Forms.DataGridViewCheckBoxColumn ColIDE;
        private System.Windows.Forms.DataGridViewTextBoxColumn Dir;
        private System.Windows.Forms.DataGridViewCheckBoxColumn ColRTR;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColDLC;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData0;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData1;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData2;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData3;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData4;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData5;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData6;
        private System.Windows.Forms.DataGridViewTextBoxColumn ColData7;
        private System.ComponentModel.BackgroundWorker CanRxWorker;
    }
}

