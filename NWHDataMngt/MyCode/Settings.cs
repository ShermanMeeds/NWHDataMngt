using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;

using DataLayer;

namespace DataMngt.MyCode
{
    public class Settings
    {
        #region Startup

        public int UserId { get; set; }

        public bool hasSettings { get; set; }
        
        private Dictionary<string, string> settings = new Dictionary<string, string>();
        
        private DataMngtTool DataObj = new DataMngtTool();

        public bool CheckForSettings(int UserId)
        {
            this.UserId = UserId;

            hasSettings = false;

            try
            {
                DataTable setts = DataObj.RetrieveSettings(UserId);

                if (setts.Rows.Count == 0)
                {
                    return false;
                }
           

                hasSettings = true;

                foreach (DataRow settsRow in setts.Rows)
                {
                    settings.Add(settsRow[SalesPlanResources.settingsColControlName].ToString(),
                                 settsRow[SalesPlanResources.settingsColControlValue].ToString());

                }
            }
            catch (Exception ex)
            {
                string here = "i am";
            }
            return hasSettings;
        }

        #endregion

        #region Maintain_Settings

        // this is used to maintain the settings dictionary which is actually 
        // passed into the routine that writes the settings to SQL
        public bool UpdateSettingsEntry(string ControlName, string ControlValue)
        {
            bool isGood = false;

            if (settings.ContainsKey(ControlName))
            {
                settings.Remove(ControlName);
            }

            settings.Add(ControlName, ControlValue);

            isGood = true;

            return isGood;
        }

        #endregion

        #region #Save_Screen_Settings

        public void SaveAllSettings()
        {
            // turn the dictionary into a datatable and pass the datatable into the write/rewrite routine
            DataTable Settings = new DataTable();
            Settings.Columns.Add(new DataColumn(SalesPlanResources.settingsColUserId, typeof(int)));
            Settings.Columns.Add(new DataColumn(SalesPlanResources.settingsColControlName, typeof(string)));
            Settings.Columns.Add(new DataColumn(SalesPlanResources.settingsColControlValue, typeof(string)));

            foreach (KeyValuePair<string, string> settItem in settings)
            {
                DataRow settRow = Settings.NewRow();

                settRow[SalesPlanResources.settingsColUserId] = UserId;
                settRow[SalesPlanResources.settingsColControlName] = settItem.Key;
                settRow[SalesPlanResources.settingsColControlValue] = settItem.Value;

                Settings.Rows.Add(settRow);
            }

            bool isDone = DataObj.SaveSettings(Settings);
        }

        public void SaveTheControl(RadioButton radioButton, string controlName)
        {
            string outValue = radioButton.Checked.ToString();

            UpdateSettingsEntry(controlName, outValue);
        }

        public void SaveTheControl(CheckBox checkBox, string controlName)
        {
            string outValue = checkBox.Checked.ToString();

            UpdateSettingsEntry(controlName, outValue);
        }

        public void SaveTheControl(DropDownList dropdownList, string controlName)
        {
            List<string> items = new List<string>();

            foreach (ListItem listItem in dropdownList.Items)
            {
                string xmlString = Serialize(listItem);
                items.Add(xmlString);
            }

            string[] itemArr = items.ToArray();
            UpdateSettingsEntry(controlName, string.Join(SalesPlanResources.arraySep, itemArr));
        }

        public void SaveTheControl(CheckBoxList checkBoxList, string controlName)
        {
            List<string> items = new List<string>();

            foreach (ListItem listItem in checkBoxList.Items)
            {
                string xmlString = Serialize(listItem);
                items.Add(xmlString);
            }

            string[] itemArr = items.ToArray();
            UpdateSettingsEntry(controlName, string.Join(SalesPlanResources.arraySep, itemArr));
        }

        public void SaveTheControl(ListBox listBox, string controlName)
        {
            List<string> items = new List<string>();

            foreach (ListItem listItem in listBox.Items)
            {
                string xmlString = Serialize(listItem);
                items.Add(xmlString);
            }

            string[] itemArr = items.ToArray();
            UpdateSettingsEntry(controlName, string.Join(SalesPlanResources.arraySep, itemArr));
        }

        private string Serialize(ListItem listItem)
        {
            XElement xml = new XElement
                            (
                                SalesPlanResources.xmlListItem,
                                        new XAttribute(SalesPlanResources.xmltext, listItem.Text.ToString()),
                                        new XAttribute(SalesPlanResources.xmlvalue, listItem.Value.ToString()),
                                        new XAttribute(SalesPlanResources.xmlselected, listItem.Selected)
                            );

            return xml.ToString();
        }

        #endregion


        #region LoadingSavedValues

        public void SetTheControl(RadioButton radioButton, string controlName)
        {
            if (!settings.ContainsKey(controlName))
            {
                return;
            }

            string controlValue = string.Empty;

            settings.TryGetValue(controlName, out controlValue);

            bool theSetting = false;

            bool.TryParse(controlValue.Trim(), out theSetting);

            radioButton.Checked = theSetting;
        }

        public void SetTheControl(CheckBox checkBox, string controlName)
        {
            if (!settings.ContainsKey(controlName))
            {
                return;
            }

            string controlValue = string.Empty;

            settings.TryGetValue(controlName, out controlValue);

            bool theSetting = false;

            bool.TryParse(controlValue.Trim(), out theSetting);

            checkBox.Checked = theSetting;
        }

        public void SetTheControl(DropDownList dropdownList, string controlName, bool ReloadValues)
        {
            if (!settings.ContainsKey(controlName))
            {
                return;
            }

            string controlValue = string.Empty;

            settings.TryGetValue(controlName, out controlValue);

            string[] listEntries = controlValue.Split(new char[] { Convert.ToChar(SalesPlanResources.arraySep) }, StringSplitOptions.RemoveEmptyEntries);

            if (ReloadValues)
            {
                dropdownList.Items.Clear();
            }

            foreach(string listEntry in listEntries)
            {
                ListItem newItem = Deserialize(listEntry);

                if (ReloadValues)
                {
                    dropdownList.Items.Add(newItem);
                    continue;
                }

                if (newItem.Selected == true)
                {
                    for(int i = 0; i < dropdownList.Items.Count; i++)
                    {
                        if (string.Compare(newItem.Value.ToString(), dropdownList.Items[i].Value.ToString())==0)
                        {
                            dropdownList.Items[i].Selected = true;
                            return;
                        }
                    }

                }
            }
        }
        
        public void SetTheControl(CheckBoxList checkboxList, string controlName, bool ReloadValues)
        {
            if (!settings.ContainsKey(controlName))
            {
                return;
            }

            string controlValue = string.Empty;

            settings.TryGetValue(controlName, out controlValue);

            string[] listEntries = controlValue.Split(new char[] { Convert.ToChar(SalesPlanResources.arraySep) }, StringSplitOptions.RemoveEmptyEntries);

            if (ReloadValues)
            {
                checkboxList.Items.Clear();
            }

            foreach (string listEntry in listEntries)
            {
                ListItem newItem = Deserialize(listEntry);

                if (ReloadValues)
                {
                    checkboxList.Items.Add(newItem);
                    continue;
                }

                if (newItem.Selected == true)
                {
                    for (int i = 0; i < checkboxList.Items.Count; i++)
                    {
                        if (string.Compare(newItem.Value.ToString(), checkboxList.Items[i].Value.ToString()) == 0)
                        {
                            checkboxList.Items[i].Selected = true;
                            break;
                        }
                    }

                }
            }
        }

        public void SetTheControl(ListBox listbox, string controlName, bool ReloadValues)
        {
            if (!settings.ContainsKey(controlName))
            {
                return;
            }

            string controlValue = string.Empty;

            settings.TryGetValue(controlName, out controlValue);

            string[] listEntries = controlValue.Split(new char[] { Convert.ToChar(SalesPlanResources.arraySep) }, StringSplitOptions.RemoveEmptyEntries);

            if (ReloadValues)
            {
                listbox.Items.Clear();
            }

            foreach (string listEntry in listEntries)
            {
                ListItem newItem = Deserialize(listEntry);

                if (ReloadValues)
                {
                    listbox.Items.Add(newItem);
                    continue;
                }

                if (newItem.Selected == true)
                {
                    for (int i = 0; i < listbox.Items.Count; i++)
                    {
                        if (string.Compare(newItem.Value.ToString(), listbox.Items[i].Value.ToString()) == 0)
                        {
                            listbox.Items[i].Selected = true;
                            break;
                        }
                    }

                }
            }
        }

        private ListItem Deserialize(string xmlInput)
        {
            ListItem listItem = new ListItem();

            XDocument xml = XDocument.Parse(xmlInput);

            var listVals =
                from lst in xml.Descendants(SalesPlanResources.xmlListItem)
                select new
                {
                    Text = (string)lst.Attribute(SalesPlanResources.xmltext),
                    Value = (string)lst.Attribute(SalesPlanResources.xmlvalue),
                    Selected = (bool)lst.Attribute(SalesPlanResources.xmlselected)
                };

            foreach (var listitm in listVals)
            {
                listItem.Text = listitm.Text;
                listItem.Value = listitm.Value;
                listItem.Selected = listitm.Selected;

                break;
            }

            return listItem;
        }

        #endregion
    }
}