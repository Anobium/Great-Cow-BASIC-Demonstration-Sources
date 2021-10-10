using System;
using System.Timers;
using LibUsbDotNet;
using LibUsbDotNet.Main;
using LibUsbDotNet.DeviceNotify;

namespace GCBlib
{
    public class USBlib
    {
        public const string LibUsbDotNet_Version = "2.2.9.110";
        public Int32 USB_VID = 0x1209;
        public Int32 USB_PID = 0x2006;
        public Int32 USB_REV = 0x0000;     
        public UsbDevice Device = null;
        public IDeviceNotifier USBDeviceNotifier = DeviceNotifier.OpenDeviceNotifier();
        public bool Initialized = false;
        public bool KeepAliveError = false;


        private readonly Timer live_timer = new Timer();
        private int KeepAliveCounter;
        

        public bool GetConnectedStatus()
        {
            if (Device != null)
            {
                return true;
            }
            else
            {
                return false;
            }   
        }

        public void InitializeUSB()
        {
            if (Initialized == false)
            {
                try
            {
                USBDeviceNotifier.OnDeviceNotify += OnUSBdeviceEventRaised;
                live_timer.Interval = 1000;
                live_timer.Elapsed += USBdaemonHandler;
                live_timer.AutoReset = true;
                live_timer.Enabled = true;
                KeepAliveCounter = 0;
                Initialized = true;
            }
            catch
            {
                throw new InvalidOperationException("Error, Can't initialize USB");
            }
            }
        }

        private void USBdaemonHandler(object sender, ElapsedEventArgs e)
        {
            try
            {
                live_timer.Enabled = false;
                if (Device == null)
                {
                    FindUSBDevice();
                    if (!(Device == null))
                    {
                        KeepAliveCounter = 9;
                    }
                }

                if (!(Device == null))
                {    
                    if (KeepAliveCounter == 9)
                    {
                        PollKeepAlive();
                        KeepAliveCounter = 0;
                    }
                    else
                    {
                        KeepAliveCounter++;
                    }
                }
                else
                {
                    KeepAliveCounter = 9;
                }
                live_timer.Interval = 1000;
                live_timer.Enabled = true;
                // add event handler?
                   
            }
            catch
            {
                throw new InvalidOperationException("Internal daemon error");
            }

        }

        private void OnUSBdeviceEventRaised(object sender, DeviceNotifyEventArgs e)
        {
            try
            {
                if ((e.Device.IdProduct == USB_PID)
                            && (e.Device.IdVendor == USB_VID))
                {
                    if ((((int)e.EventType) == 0x8004))
                    {
                        if (!(Device == null))
                        {
                            Device.Close();
                            Device = null;
                        }
                           //add event handler ?
                    }

                }
            }
            catch
            {

            }
        }

        public void TerminateUSB()
        {
            if (Initialized == true)
            {
                try
                {

                    live_timer.Enabled = false;
                    if (!(Device == null))
                    {
                        Device.Close();
                    }
                }
                catch
                {
                    throw new InvalidOperationException("Error, Can't Terminate USB");
                }
                    Device = null;
                
            try
            {
                    USBDeviceNotifier.Enabled = false;
                    USBDeviceNotifier.OnDeviceNotify -= OnUSBdeviceEventRaised;
                    live_timer.Enabled = false;
                    live_timer.Elapsed -= USBdaemonHandler;
                }
            catch
            {
                    throw new InvalidOperationException("Error, Can't Terminate USB");
            }
            Initialized = false;
            }
        }

        public bool FindUSBDevice()
        {
            UsbDeviceFinder Finder = new UsbDeviceFinder(USB_VID, USB_PID, USB_REV);
            try
            {
                Device = UsbDevice.OpenUsbDevice(Finder);
            }
            catch
            {
                Device = null;
            }
            // test if GetStatusfromDeviceUponInit is needed
            return !(Device == null);
            }


        public void SendData(byte Request, byte Data)
        {
            if (Device != null)
            {
                live_timer.Interval = 10000;
                byte[] InBuffer = new byte[1024];
                try
                {
                    UsbSetupPacket SetupPacket = new UsbSetupPacket(66, Request, Data, 0, 0);
                    Device.ControlTransfer(ref SetupPacket, InBuffer, 1000, out int inCount);
                }
                catch
                {

                }
                KeepAliveCounter = 0;
                live_timer.Interval = 1000;
                live_timer.Enabled = true;
            }
        }
    
        public void SendData(byte Request, byte[] Buffer)
        {
            if (Device != null)
            {
                int CopyLoc;
                live_timer.Interval = 10000;
                byte[] InBuffer = new byte[1024];
                try
                {
                    UsbSetupPacket SetupPacket = new UsbSetupPacket(66, Request, Buffer.Length, 0, 0);
                    Device.ControlTransfer(ref SetupPacket, InBuffer, 1000, out int inCount);

                    for (CopyLoc = 0; CopyLoc <= Buffer.Length - 1; CopyLoc++)
                    {
                        SetupPacket = new UsbSetupPacket(66, Request, Buffer[CopyLoc], 0, 0);
                        Device.ControlTransfer(ref SetupPacket, InBuffer, 1000, out inCount);
                    } 
                }
                catch
                {
                
                }
                KeepAliveCounter = 0;
                live_timer.Interval = 1000;
                live_timer.Enabled = true;
            }
        }

        public void SendData(byte Request)
        {
            if (Device != null)
            {
                live_timer.Interval = 10000;
                byte[] InBuffer = new byte[1024];
                try
                {
                    UsbSetupPacket SetupPacket = new UsbSetupPacket(66, Request, 0, 0, 0);
                    Device.ControlTransfer(ref SetupPacket, InBuffer, 1000, out int inCount);
                }
                catch
                {
                   
                }
                KeepAliveCounter = 0;
                live_timer.Interval = 1000;
                live_timer.Enabled = true;
            }
        }

        public byte[] ReadData(byte Request, short ReplySize)
        {
            if (Device != null)
            {
                live_timer.Interval = 10000;
                int CopyLoc;
                int inCount = -1;
                byte[] InBuffer = new byte[1024];
                try
                {
                    UsbSetupPacket SetupPacket = new UsbSetupPacket(194, Request, 0, 0, ReplySize);
                    Device.ControlTransfer(ref SetupPacket, InBuffer, ReplySize, out inCount);
                }
                catch
                {

                }
                byte[] OutBuffer = new byte[inCount];
                //test if works as spected and add the "using" if it do the trick
                //   System.Runtime.InteropServices.Marshal.Copy(InBuffer,OutBuffer, 0, CopyLoc);
                for (CopyLoc = 0; CopyLoc <= inCount - 1; CopyLoc++)
                {
                    OutBuffer[CopyLoc] = InBuffer[CopyLoc];
                }
                KeepAliveCounter = 0;
                live_timer.Interval = 1000;
                live_timer.Enabled = true;

                if (OutBuffer != null && OutBuffer.Length > 0)
                {
                    return OutBuffer;
                }
                else
                {
                    return null;
                }
            }
            else
            {
                //test and decide if return null

                return null;
            }
        }

        public object ReadData(byte Request)
        {
            if (Device != null)
            {
                live_timer.Interval = 10000;
                int CopyLoc;
                int inCount = -1;
                int ReplySize = 1;
                byte[] InBuffer = new byte[1024];
                try
                {
                    UsbSetupPacket SetupPacket = new UsbSetupPacket(194, Request, 0, 0, ReplySize);
                    Device.ControlTransfer(ref SetupPacket, InBuffer, ReplySize, out inCount);
                }
                catch
                {

                }
                short[] OutBuffer = new short[inCount];
                //test if works as spected and add the "using" if it do the trick
                //   System.Runtime.InteropServices.Marshal.Copy(InBuffer,OutBuffer, 0, CopyLoc);
                for (CopyLoc = 0; CopyLoc <= inCount - 1; CopyLoc++)
                {
                    OutBuffer[CopyLoc] = InBuffer[CopyLoc];
                }
                KeepAliveCounter = 0;
                live_timer.Interval = 1000;
                live_timer.Enabled = true;

                if (OutBuffer != null && OutBuffer.Length > 0)
                {
                    return OutBuffer[0];
                }
                else
                {
                    return null;
                }
            }
            else
            {
                            
                return null;
            }
        }

        private void PollKeepAlive()
        {
            byte[] Reply;
            KeepAliveError = false;
            Reply = ReadData(255, 1);

            try
            {
                if (Reply[0] != 255)
            {
                KeepAliveError = true;
                Device.Close();
                Device = null;
                    
            }
            }
            catch
            {
                         
            }
        }

      
        // test if delay sub is needed

    }
}

