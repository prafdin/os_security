using Lab5.Commands;
using Lab5.Models;
using System;
using System.ComponentModel;
using System.Windows;
using System.Windows.Forms;

namespace Lab5.ViewModels
{
    public class ShareViewModel : INotifyPropertyChanged
    {
        private NetShares.SHARE_INFO_502 shareInfo;
        private NetShares _netShares;

        public string Name
        {
            get => shareInfo.shi502_netname;
            set
            {
                if (shareInfo.shi502_netname == value) return;
                shareInfo.shi502_netname = value;
                OnPropertyChanged(nameof(Name));
            }
        }
        public string Path
        {
            get => shareInfo.shi502_path;
            set
            {
                if (shareInfo.shi502_path == value) return;
                shareInfo.shi502_path = value;
                OnPropertyChanged(nameof(Path));
            }
        }

        public ShareViewModel()
        {
            shareInfo = new NetShares.SHARE_INFO_502();
            shareInfo.shi502_type = NetShares.SHARE_TYPE.STYPE_DISKTREE;
            shareInfo.shi502_permissions = 0;    // ignored for user-level security
            shareInfo.shi502_max_uses = -1;
            shareInfo.shi502_current_uses = 0;    // ignored for set
            shareInfo.shi502_passwd = null;        // ignored for user-level security
            shareInfo.shi502_reserved = 0;
            shareInfo.shi502_security_descriptor = IntPtr.Zero;
        }

        public void Initialize(NetShares netShares)
        {
            _netShares = netShares;

            OpenFolderCommand = new Command(_ =>
            {
                var fbd = new FolderBrowserDialog();
                fbd.ShowDialog();
                Path = fbd.SelectedPath;
            }, null);

            AddShareCommand = new Command(obj =>
           {
               _netShares.AddShare("localhost", shareInfo);
               Window Win = obj as Window;
               Win.Close();
           }, null);
        }

        public Command OpenFolderCommand { get; set; }
        public Command AddShareCommand { get; set; }


        public event PropertyChangedEventHandler PropertyChanged;

        private void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
