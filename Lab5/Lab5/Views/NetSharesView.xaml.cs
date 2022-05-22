using System.Windows;
using System.Windows.Controls;

namespace Lab5.Views
{
    /// <summary>
    /// Interaction logic for NetSharesView.xaml
    /// </summary>
    public partial class NetSharesView : Window
    {
        public NetSharesView()
        {
            InitializeComponent();
        }

        private void DataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}
