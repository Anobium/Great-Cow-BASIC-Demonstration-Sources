using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace DrvSetup
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Great Cow Basic USB Driver Setup");
            Console.WriteLine("");
            Console.WriteLine("");
            Console.WriteLine("Please accept the Driver installation...");
            Console.WriteLine("At the end of the installation, the computer will restart automatically.");

            try
            {
                ProcessStartInfo p = new ProcessStartInfo();
                p.FileName = "bcdedit.exe";
                p.Arguments = "/set testsigning off";
                p.WindowStyle = ProcessWindowStyle.Hidden;
                Process x = Process.Start(p);
                x.WaitForExit();
                
            }
            catch
            {

               // Environment.Exit(0);
            }

            try
            {
                ProcessStartInfo p = new ProcessStartInfo();
                p.FileName = "pnputil.exe";
                p.Arguments = "-i -a C:\\Drivers\\GCBASIC_USBLibKWINUSB.inf";
                p.WindowStyle = ProcessWindowStyle.Minimized;
                Process x = Process.Start(p);
                x.WaitForExit();
              
            }
            catch
            {

              //  Environment.Exit(0);
            }

            try
            {
                ProcessStartInfo p = new ProcessStartInfo();
                p.FileName = "shutdown.exe";
                p.Arguments = "/r /t 10";
                p.WindowStyle = ProcessWindowStyle.Hidden;
                Process x = Process.Start(p);
                x.WaitForExit();
                
            }
            catch
            {

              //  Environment.Exit(0);
            }

            try
            {
                ProcessStartInfo p = new ProcessStartInfo();
                p.FileName = "C:\\Drivers\\Clear.exe";
                p.Arguments = "/X /S";
                p.WindowStyle = ProcessWindowStyle.Hidden;
                Process x = Process.Start(p);
                x.WaitForExit();
               
            }
            catch
            {

              //  Environment.Exit(0);
            }

        }
    }
}
