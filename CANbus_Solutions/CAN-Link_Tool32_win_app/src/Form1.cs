using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using GCBlib;

namespace Tool32
{

    public partial class Form1 : Form
    {
        USBlib USB = new USBlib();
        uint ID;
        uint Mask;
        uint Filter;
        byte[] BytesID = new byte[4];
        byte[] BytesMask = new byte[4];
        byte[] BytesFilter = new byte[4];
        byte[] RxFrame = new byte[1];
        byte DLC = 1;
        byte Flags;
        byte[] Data = new byte[8];
        byte MaskMode = 3;

        uint RXID;
        byte[] RXIDbytes = new byte[4];
        int RTR;
        bool IDE;
        bool rxworker = false;
        DateTime StartTime;

        public Form1()
        {
            InitializeComponent();

        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (sndForce.Checked)
            { Flags = 1; }

            if (sndRTR.Checked)
            {
                Flags = 2;

                sndData0.Enabled = false;
                sndData0.Value = 0;
                sndData1.Enabled = false;
                sndData1.Value = 0;
                sndData2.Enabled = false;
                sndData2.Value = 0;
                sndData3.Enabled = false;
                sndData3.Value = 0;
                sndData4.Enabled = false;
                sndData4.Value = 0;
                sndData5.Enabled = false;
                sndData5.Value = 0;
                sndData6.Enabled = false;
                sndData6.Value = 0;
                sndData7.Enabled = false;
                sndData7.Value = 0;

            }
            else
            {
                switch (sndDLC.Value)
                {
                    case 0:
                        sndData0.Enabled = false;
                        sndData0.Value = 0;
                        sndData1.Enabled = false;
                        sndData1.Value = 0;
                        sndData2.Enabled = false;
                        sndData2.Value = 0;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 1:
                        sndData0.Enabled = true;
                        sndData1.Enabled = false;
                        sndData1.Value = 0;
                        sndData2.Enabled = false;
                        sndData2.Value = 0;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 2:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = false;
                        sndData2.Value = 0;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 3:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 4:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 5:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 6:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = true;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 7:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = true;
                        sndData6.Enabled = true;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 8:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = true;
                        sndData6.Enabled = true;
                        sndData7.Enabled = true;
                        break;
                }
            }

            if ((sndForce.Checked) && (sndRTR.Checked))
            { Flags = 3; }
            if ((sndForce.Checked == false) && (sndRTR.Checked == false))
            { Flags = 0; }


        }



        private void toolMode_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }


        private void sndDLC_ValueChanged(object sender, EventArgs e)
        {
            if (sndRTR.Checked == false)
            {
                switch (sndDLC.Value)
                {
                    case 0:
                        sndData0.Enabled = false;
                        sndData0.Value = 0;
                        sndData1.Enabled = false;
                        sndData1.Value = 0;
                        sndData2.Enabled = false;
                        sndData2.Value = 0;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 1:
                        sndData0.Enabled = true;
                        sndData1.Enabled = false;
                        sndData1.Value = 0;
                        sndData2.Enabled = false;
                        sndData2.Value = 0;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 2:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = false;
                        sndData2.Value = 0;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 3:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = false;
                        sndData3.Value = 0;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 4:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = false;
                        sndData4.Value = 0;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 5:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = false;
                        sndData5.Value = 0;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 6:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = true;
                        sndData6.Enabled = false;
                        sndData6.Value = 0;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 7:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = true;
                        sndData6.Enabled = true;
                        sndData7.Enabled = false;
                        sndData7.Value = 0;
                        break;
                    case 8:
                        sndData0.Enabled = true;
                        sndData1.Enabled = true;
                        sndData2.Enabled = true;
                        sndData3.Enabled = true;
                        sndData4.Enabled = true;
                        sndData5.Enabled = true;
                        sndData6.Enabled = true;
                        sndData7.Enabled = true;
                        break;
                }
            }

            DLC = Convert.ToByte(sndDLC.Value);
            hexDLC.Text = DLC.ToString("X2");

        }



        private void sndID_ValueChanged(object sender, EventArgs e)
        {
            if ((sndID.Value > 2047) || (sndForce.Checked))
            {
                sndIDE.Checked = true;
            }
            else
            {
                sndIDE.Checked = false;
            }
            ID = Convert.ToUInt32(sndID.Value);
            BytesID = BitConverter.GetBytes(ID);
            hexID.Text = ID.ToString("X");

        }

        private void sndData0_ValueChanged(object sender, EventArgs e)
        {
            Data[0] = Convert.ToByte(sndData0.Value);
            hexData0.Text = Data[0].ToString("X2");
        }

        private void sndData1_ValueChanged(object sender, EventArgs e)
        {
            Data[1] = Convert.ToByte(sndData1.Value);
            hexData1.Text = Data[1].ToString("X2");
        }

        private void sndData2_ValueChanged(object sender, EventArgs e)
        {
            Data[2] = Convert.ToByte(sndData2.Value);
            hexData2.Text = Data[2].ToString("X2");
        }

        private void sndData3_ValueChanged(object sender, EventArgs e)
        {
            Data[3] = Convert.ToByte(sndData3.Value);
            hexData3.Text = Data[3].ToString("X2");
        }

        private void sndData4_ValueChanged(object sender, EventArgs e)
        {
            Data[4] = Convert.ToByte(sndData4.Value);
            hexData4.Text = Data[4].ToString("X2");
        }

        private void sndData5_ValueChanged(object sender, EventArgs e)
        {
            Data[5] = Convert.ToByte(sndData5.Value);
            hexData5.Text = Data[5].ToString("X2");
        }

        private void sndData6_ValueChanged(object sender, EventArgs e)
        {
            Data[6] = Convert.ToByte(sndData6.Value);
            hexData6.Text = Data[6].ToString("X2");
        }

        private void sndData7_ValueChanged(object sender, EventArgs e)
        {
            Data[7] = Convert.ToByte(sndData7.Value);
            hexData7.Text = Data[7].ToString("X2");
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            StartTime = DateTime.Now.ToUniversalTime();
            USB.InitializeUSB();
        }

        private void sndForce_CheckedChanged(object sender, EventArgs e)
        {
            if ((sndID.Value > 2047) || (sndForce.Checked))
            {
                sndIDE.Checked = true;
            }
            else
            {
                sndIDE.Checked = false;
            }

            if (sndForce.Checked)
            { Flags = 1; }
            if (sndRTR.Checked)
            { Flags = 2; }
            if ((sndForce.Checked) && (sndRTR.Checked))
            { Flags = 3; }
            if ((sndForce.Checked == false) && (sndRTR.Checked == false))
            { Flags = 0; }


        }

        private void sndIDE_CheckedChanged(object sender, EventArgs e)
        {
            if ((sndID.Value > 2047) || (sndForce.Checked))
            {
                sndIDE.Checked = true;
            }
            else
            {
                sndIDE.Checked = false;
            }
        }

        private void toolMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (toolMode.Text == "Listen")
            {
                USB.SendData(106);
                sndBox.Enabled = false;
            }
            else
            {
                USB.SendData(107);
                sndBox.Enabled = true;
            }
        }

        private void DeviceTimer_Tick(object sender, EventArgs e)
        {
            if (USB.GetConnectedStatus())
            {
                DeviceStatus.Text = "Device Connected";
                if (CanFPS.Enabled == false)
                {
                    toolMode.Enabled = true;
                    BitRate.Enabled = true;
                }
            }
            else
            {
                DeviceStatus.Text = "Device Not Connected";
                toolMode.Enabled = false;
                BitRate.Enabled = false;
                toolMode.Text = "Listen";
                BitRate.Text = "1000";
            }
        }

        private void TransmitBtn_Click(object sender, EventArgs e)
        {
            USB.SendData(100, BytesID);

            USB.SendData(101, Flags);

            USB.SendData(102, DLC);

            USB.SendData(103, Data);

            USB.SendData(104);



            if (sndIDE.Checked)
            {
                IDE = true;
            }
            else
            {
                IDE = false;
            }
            if (sndRTR.Checked)
            {
                RTR = 1;
            }
            else
            {
                RTR = 0;
            }

            readGridView.Rows.Add((DateTime.Now.ToUniversalTime() - StartTime).TotalMilliseconds.ToString("00000000000.00000").Replace(".", string.Empty), hexID.Text, IDE, "TX", RTR, sndDLC.Value, hexData0.Text, hexData1.Text, hexData2.Text, hexData3.Text, hexData4.Text, hexData5.Text, hexData6.Text, hexData7.Text);


            readGridView.FirstDisplayedScrollingRowIndex = readGridView.RowCount - 1;
        }

        private void RxButton_Click(object sender, EventArgs e)
        {
            if (CanRxWorker.IsBusy == true)
            {
                rxworker = false;
                CanRxWorker.CancelAsync();
                RxBtn.Text = "Start";
                toolMode.Enabled = true;
                BitRate.Enabled = true;
                FilterMode.Enabled = true;
                if (FilterMode.Text == "Filter On")
                {
                    NumMask.Enabled = true;
                    NumFilter.Enabled = true;
                    filForce.Enabled = true;
                }
            }
            else
            {
                RxFrame = USB.ReadData(105, 14);
                rxworker = true;
                CanRxWorker.RunWorkerAsync();
                RxBtn.Text = "Stop";
                toolMode.Enabled = false;
                BitRate.Enabled = false;
                FilterMode.Enabled = false;
                NumMask.Enabled = false;
                NumFilter.Enabled = false;
                filForce.Enabled = false;
            }
        }



        private void ClearBtn_Click(object sender, EventArgs e)
        {
            readGridView.Rows.Clear();
            readGridView.Refresh();
        }

        private void BitRate_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        private void BitRate_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (BitRate.Text)
            {
                case "5":
                    USB.SendData(200);
                    break;
                case "10":
                    USB.SendData(201);
                    break;
                case "20":
                    USB.SendData(202);
                    break;
                case "31.25":
                    USB.SendData(203);
                    break;
                case "33.3":
                    USB.SendData(204);
                    break;
                case "40":
                    USB.SendData(205);
                    break;
                case "50":
                    USB.SendData(206);
                    break;
                case "80":
                    USB.SendData(207);
                    break;
                case "100":
                    USB.SendData(208);
                    break;
                case "125":
                    USB.SendData(209);
                    break;
                case "200":
                    USB.SendData(210);
                    break;
                case "250":
                    USB.SendData(211);
                    break;
                case "500":
                    USB.SendData(212);
                    break;
                case "1000":
                    USB.SendData(213);
                    break;

            }
            FilterMode.Text = "Filter Off Allow All";

        }


    

        private void saveBtn_Click(object sender, EventArgs e)
        {

            if (readGridView.Rows.Count > 0)
            {
                SaveFileDialog sfd = new SaveFileDialog();
                sfd.Filter = "CSV (*.csv)|*.csv";
                sfd.FileName = "CANframes";
                bool fileError = false;
                if (sfd.ShowDialog() == DialogResult.OK)

                {
                    if (File.Exists(sfd.FileName))
                    {
                        try
                        {
                            File.Delete(sfd.FileName);
                        }
                        catch (IOException ex)
                        {
                            fileError = true;
                            MessageBox.Show("It wasn't possible to save the file" + ex.Message);
                        }
                    }
                    if (!fileError)
                    {
                        try
                        {
                            int columnCount = readGridView.Columns.Count;
                            string columnNames = "";
                            string[] outputCsv = new string[readGridView.Rows.Count + 1];

                            columnNames += "Time Stamp,ID,Extended,Dir,RTR,DLC,D0,D1,D2,D3,D4,D5,D6,D7";


                            outputCsv[0] += columnNames;

                            for (int i = 1; (i - 1) < readGridView.Rows.Count; i++)
                            {
                                for (int j = 0; j < columnCount; j++)
                                {
                                    if (readGridView.Rows[i - 1].Cells[j].Value != null)
                                    {
                                        outputCsv[i] += readGridView.Rows[i - 1].Cells[j].Value.ToString() + ",";
                                    }
                                }
                                outputCsv[i] = outputCsv[i].Remove(outputCsv[i].Length - 1);
                            }

                            File.WriteAllLines(sfd.FileName, outputCsv, Encoding.Default);

                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Error :" + ex.Message);
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("No frames to export", "Info");
            }
        }

        private void FilterMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FilterMode.Text == "Filter On")
            {
                NumMask.Enabled = true;
                NumFilter.Enabled = true;
                filForce.Enabled = true;
                MaskMode = 0;
            }
            else
            {
                NumMask.Enabled = false;
                NumFilter.Enabled = false;
                filForce.Enabled = false;
                MaskMode = 3;
            }

            USB.SendData(108, MaskMode);

        }

        private void NumMask_ValueChanged(object sender, EventArgs e)
        {
            Mask = Convert.ToUInt32(NumMask.Value);
            BytesMask = BitConverter.GetBytes(Mask);
            hexMask.Text = "0x" + Mask.ToString("X");

            if (filForce.Checked != true)
            {
                USB.SendData(109, BytesMask);
            }
            else
            {
                USB.SendData(112, BytesMask);
            }


            Filter = Convert.ToUInt32(NumFilter.Value);
            BytesFilter = BitConverter.GetBytes(Filter);
            hexFilter.Text = "0x" + Filter.ToString("X");
            if (filForce.Checked != true)
            {
                USB.SendData(110, BytesFilter);
            }
            else
            {
                USB.SendData(111, BytesFilter);
            }
        }

        private void NumFilter_ValueChanged(object sender, EventArgs e)
        {
            Mask = Convert.ToUInt32(NumMask.Value);
            BytesMask = BitConverter.GetBytes(Mask);
            hexMask.Text = "0x" + Mask.ToString("X");

            if (filForce.Checked != true)
            {
                USB.SendData(109, BytesMask);
            }
            else
            {
                USB.SendData(112, BytesMask);
            }


            Filter = Convert.ToUInt32(NumFilter.Value);
            BytesFilter = BitConverter.GetBytes(Filter);
            hexFilter.Text = "0x" + Filter.ToString("X");
            if (filForce.Checked != true)
            {
                USB.SendData(110, BytesFilter);
            }
            else
            {
                USB.SendData(111, BytesFilter);
            }
        }

        private void filForce_CheckedChanged(object sender, EventArgs e)
        {
            Mask = Convert.ToUInt32(NumMask.Value);
            BytesMask = BitConverter.GetBytes(Mask);
            hexMask.Text = "0x" + Mask.ToString("X");

            if (filForce.Checked != true)
            {
                USB.SendData(109, BytesMask);
            }
            else
            {
                USB.SendData(112, BytesMask);
            }


            Filter = Convert.ToUInt32(NumFilter.Value);
            BytesFilter = BitConverter.GetBytes(Filter);
            hexFilter.Text = "0x" + Filter.ToString("X");
            if (filForce.Checked != true)
            {
                USB.SendData(110, BytesFilter);
            }
            else
            {
                USB.SendData(111, BytesFilter);
            }

        }

        private void CanRxWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            do
            {

                RxFrame = USB.ReadData(105, 14);
                if (RxFrame != null)
                {
                    if (RxFrame.Length > 1)
                    {                     
                        RXIDbytes[0] = RxFrame[0];
                        RXIDbytes[1] = RxFrame[1];
                        RXIDbytes[2] = RxFrame[2];
                        RXIDbytes[3] = RxFrame[3];
                        RXID = BitConverter.ToUInt32(RXIDbytes, 0);

                        if ((RxFrame[4] == 1) || (RxFrame[4] == 3))
                        {
                            IDE = true;
                        }
                        else
                        {
                            IDE = false;
                        }
                        if ((RxFrame[4] == 2) || (RxFrame[4] == 3))
                        {
                            RTR = 1;
                        }
                        else
                        {
                            RTR = 0;
                        }

                        readGridView.Invoke(new Action(delegate ()
                            {
                                readGridView.Rows.Add((DateTime.Now.ToUniversalTime() - StartTime).TotalMilliseconds.ToString("00000000000.00000").Replace(".", string.Empty), RXID.ToString("X"), IDE, "RX", RTR, RxFrame[5].ToString("X"), RxFrame[6].ToString("X2"), RxFrame[7].ToString("X2"), RxFrame[8].ToString("X2"), RxFrame[9].ToString("X2"), RxFrame[10].ToString("X2"), RxFrame[11].ToString("X2"), RxFrame[12].ToString("X2"), RxFrame[13].ToString("X2"));

                                readGridView.FirstDisplayedScrollingRowIndex = readGridView.RowCount - 1;
                            }));
                    }

                }
            } while (rxworker == true);
        }


    }
}
