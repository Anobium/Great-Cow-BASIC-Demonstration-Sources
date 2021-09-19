using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using Microsoft.Win32;

namespace Unsigned
{
    class Program
    {
        static void Main(string[] args)
        {

            int rc = 0;
            string key = @"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecureBoot\State";
            string subkey = @"UEFISecureBootEnabled";
            try
            {
                object value = Registry.GetValue(key, subkey, rc);
                if (value != null)
                    rc = (int)value;
            }
            catch { }
            if (rc == 0)
            {

                try
            {
                ProcessStartInfo p = new ProcessStartInfo();
                p.FileName = "bcdedit.exe";
                p.Arguments = "/set testsigning on";
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
                p.FileName = "shutdown.exe";
                p.Arguments = "/r /t 5";
                p.WindowStyle = ProcessWindowStyle.Hidden;
                Process x = Process.Start(p);
                x.WaitForExit();
                
            }
            catch
            {

               // Environment.Exit(0);
            }
            }
            else
            {
                Console.WriteLine("Secure Boot has been detected and is enabled on the computer.");
                Console.WriteLine("Now the computer will restart and the boot menu will be displayed.");
                Console.WriteLine("please select from the menu: Trobleshoot > Advanced Options > ");
                Console.WriteLine(" Start-Up Settings > Restart.");
                  Console.WriteLine("Once restarted, press key 7 (Disable driver signature enforcement).");
                Console.WriteLine("");
                Console.WriteLine("");
                Console.WriteLine("");
                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
                try
                {
                    ProcessStartInfo p = new ProcessStartInfo();
                    p.FileName = "shutdown.exe";
                    p.Arguments = "/r /o /t 5";
                    p.WindowStyle = ProcessWindowStyle.Hidden;
                    Process x = Process.Start(p);
                    x.WaitForExit();
                   
                }
                catch
                {

                    // Environment.Exit(0);
                }

            }

            

        }
    }
}
