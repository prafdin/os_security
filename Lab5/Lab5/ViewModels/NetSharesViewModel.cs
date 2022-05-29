using Lab5.Commands;
using Lab5.Models;
using Lab5.Views;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;

namespace Lab5.ViewModels
{
    class NetSharesViewModel : INotifyPropertyChanged
    {
        private NetShares netShares;

        public ObservableCollection<NetShares.SHARE_INFO_502> Shares { get; set; } = new();

        public NetSharesViewModel()
        {
            string serverName = "localhost";
            netShares = new NetShares(serverName);

            UpdateObservableCollection();

            ShowAddShareCommand = new Command(_ =>
            {
                var shareViewModel = new ShareViewModel();
                shareViewModel.Initialize(netShares);
                var shareView = new AddShareView(shareViewModel);
                var res = shareView.ShowDialog();
                if (res.Value)
                    UpdateObservableCollection();
            }, null);
        }

        private void UpdateObservableCollection()
        {
            netShares.Update();
            foreach (var newShare in netShares.Shares)
            {
                if (!Shares.Any(s => s.shi502_netname == newShare.shi502_netname))
                    Shares.Add(newShare);
            }
        }

        public Command ShowAddShareCommand { get; }

        public event PropertyChangedEventHandler? PropertyChanged;
        private void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
