using Lab5.ViewModels;
using System.Windows;

namespace Lab5.Views
{
    /// <summary>
    /// Interaction logic for AddShareView.xaml
    /// </summary>
    public partial class AddShareView : Window
    {
        public AddShareView()
        {
            InitializeComponent();
        }

        public AddShareView(ShareViewModel shareViewModel)
        {
            InitializeComponent();
            DataContext = shareViewModel;
        }
        public void button_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
        }
    }




}
