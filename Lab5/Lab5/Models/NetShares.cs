using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace Lab5.Models
{
    public class NetShares
    {
        #region External Calls
        [DllImport("Netapi32.dll", SetLastError = true)]
        static extern int NetApiBufferFree(IntPtr Buffer);
        [DllImport("Netapi32.dll", CharSet = CharSet.Unicode)]
        private static extern int NetShareEnum(
             StringBuilder ServerName,
             int level,
             ref IntPtr bufPtr,
             uint prefmaxlen,
             ref int entriesread,
             ref int totalentries,
             ref int resume_handle
             );
        [DllImport("Netapi32.dll")]
        private static extern uint NetShareAdd(
        [MarshalAs(UnmanagedType.LPWStr)] string strServer,
        Int32 dwLevel,
        ref SHARE_INFO_502 buf,
        out uint parm_err
        );
        #endregion
        #region External Structures
        [StructLayout(LayoutKind.Sequential)]
        public struct SHARE_INFO_502
        {
            [MarshalAs(UnmanagedType.LPWStr)] public string shi502_netname;
            public SHARE_TYPE shi502_type;
            [MarshalAs(UnmanagedType.LPWStr)] public string shi502_remark;
            public Int32 shi502_permissions;
            public Int32 shi502_max_uses;
            public Int32 shi502_current_uses;
            [MarshalAs(UnmanagedType.LPWStr)] public string shi502_path;
            [MarshalAs(UnmanagedType.LPWStr)] public string shi502_passwd;
            public Int32 shi502_reserved;
            public IntPtr shi502_security_descriptor;

            public SHARE_INFO_502(string shi502_netname, SHARE_TYPE shi502_type, string shi502_remark, int shi502_permissions, int shi502_max_uses, int shi502_current_uses, string shi502_path, string shi502_passwd, int shi502_reserved, IntPtr shi502_security_descriptor)
            {
                this.shi502_netname = shi502_netname;
                this.shi502_type = shi502_type;
                this.shi502_remark = shi502_remark;
                this.shi502_permissions = shi502_permissions;
                this.shi502_max_uses = shi502_max_uses;
                this.shi502_current_uses = shi502_current_uses;
                this.shi502_path = shi502_path;
                this.shi502_passwd = shi502_passwd;
                this.shi502_reserved = shi502_reserved;
                this.shi502_security_descriptor = shi502_security_descriptor;
            }

            public override string ToString()
            {
                return shi502_netname;
            }
        }
        #endregion
        public enum SHARE_TYPE : uint
        {
            STYPE_DISKTREE = 0,
            STYPE_PRINTQ = 1,
            STYPE_DEVICE = 2,
            STYPE_IPC = 3,
            STYPE_TEMPORARY = 0x40000000,
            STYPE_SPECIAL = 0x80000000,
        }
        const uint MAX_PREFERRED_LENGTH = 0xFFFFFFFF;
        const int NERR_Success = 0;

        public IEnumerable<SHARE_INFO_502> Shares { get; set; }

        public NetShares()
        {
            Shares = new List<SHARE_INFO_502>();
        }
        public NetShares(string server)
        {
            Shares = EnumNetShares(server);
        }

        public void Update()
        {
            string Server = "localhost";
            List<SHARE_INFO_502> ShareInfos = new List<SHARE_INFO_502>();
            int entriesread = 0;
            int totalentries = 0;
            int resume_handle = 0;
            int nStructSize = Marshal.SizeOf(typeof(SHARE_INFO_502));
            IntPtr bufPtr = IntPtr.Zero;
            StringBuilder server = new StringBuilder(Server);
            int ret = NetShareEnum(server, 502, ref bufPtr, MAX_PREFERRED_LENGTH, ref entriesread, ref totalentries, ref resume_handle);
            if (ret == NERR_Success)
            {
                IntPtr currentPtr = bufPtr;
                for (int i = 0; i < entriesread; i++)
                {
                    SHARE_INFO_502 shi1 = (SHARE_INFO_502)Marshal.PtrToStructure(currentPtr, typeof(SHARE_INFO_502));
                    ShareInfos.Add(shi1);
                    currentPtr += nStructSize;
                }
                NetApiBufferFree(bufPtr);
                Shares = ShareInfos.ToArray();
            }
            else
            {
                Shares = ShareInfos.ToArray();
            }
        }

        private SHARE_INFO_502[] EnumNetShares(string Server)
        {
            List<SHARE_INFO_502> ShareInfos = new List<SHARE_INFO_502>();
            int entriesread = 0;
            int totalentries = 0;
            int resume_handle = 0;
            int nStructSize = Marshal.SizeOf(typeof(SHARE_INFO_502));
            IntPtr bufPtr = IntPtr.Zero;
            StringBuilder server = new StringBuilder(Server);
            int ret = NetShareEnum(server, 502, ref bufPtr, MAX_PREFERRED_LENGTH, ref entriesread, ref totalentries, ref resume_handle);
            if (ret == NERR_Success)
            {
                IntPtr currentPtr = bufPtr;
                for (int i = 0; i < entriesread; i++)
                {
                    SHARE_INFO_502 shi1 = (SHARE_INFO_502)Marshal.PtrToStructure(currentPtr, typeof(SHARE_INFO_502));
                    ShareInfos.Add(shi1);
                    currentPtr += nStructSize;
                }
                NetApiBufferFree(bufPtr);
                return ShareInfos.ToArray();
            }
            else
            {
                return ShareInfos.ToArray();
            }
        }

        public bool AddShare(string server, SHARE_INFO_502 shareEnum)
        {
            uint error = 0;
            return NetShareAdd(server, 502, ref shareEnum, out error) == 0;
        }

    }
}
