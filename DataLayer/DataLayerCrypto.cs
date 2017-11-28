using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer
{
  using System.Security.Cryptography;
  using System.Text;
  using System.IO;

  /// <summary>
  /// Simple TripleDES implementation for private string encryption/decryption
  /// </summary>
  internal class CoFormsCrypto
  {
    #region  Member Variables

    private const string _keyphrase = "BM33keyeboqu";
    private byte[] _myIV = new byte[] { 12, 199, 5, 25, 199, 83, 33, 1, 155, 156, 100 };
    //private PaddingMode _ppad = PaddingMode.None;
    //private CipherMode _pmode = CipherMode.ECB;
    private byte[] _myKey;

    #endregion

    #region  CTOR

    /// <summary>
    /// Creates a new instance of a BudgetTrackerCrypto object
    /// </summary>
    /// <remarks></remarks>
    public CoFormsCrypto()
    {
      // Set key and iv/salt arrays to valid tdes size
      byte[] abytSalt = new byte[12];
      byte[] abytKey = new byte[24];
      // Use PasswordDeriveBytes instance to derive a key
      using (Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(_keyphrase, abytSalt))
      {
        // Get the same amount of bytes as the current abytKey length
        _myKey = pdb.GetBytes(abytKey.Length);
      }
    }

    #endregion

    #region  Encrypt/Decrypt

    public string EncryptToBase64(string str)
    {
      string sret = string.Empty;

      // Create crypto provider
      using (TripleDESCryptoServiceProvider _tdes = new TripleDESCryptoServiceProvider())
      {
        // Create Encryptor
        using (ICryptoTransform encryptor = _tdes.CreateEncryptor(_myKey, _myIV))
        {
          // Encrypt the data to a memory stream
          using (MemoryStream msEncrypt = new MemoryStream())
          {
            // Get a cryptostream
            CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write);

            // Convert the data to a byte array
            byte[] toEncrypt = Encoding.ASCII.GetBytes(str);
            // Write all data to the crypto stream and flush it
            csEncrypt.Write(toEncrypt, 0, toEncrypt.Length);
            csEncrypt.FlushFinalBlock();
            // Get Encrypted array of bytes
            sret = Convert.ToBase64String(msEncrypt.ToArray());
            // Clean up
            toEncrypt = null;
            //csEncrypt.Close();
            //msEncrypt.Close();
          }
        }
        _tdes.Clear();
      }

      // Return result
      return sret;
    }

    public string DecryptFromBase64(string base64Input)
    {
      string sret = string.Empty;
      
      // Create crypto provider
      using (TripleDESCryptoServiceProvider _tdes = new TripleDESCryptoServiceProvider())
      {
        // Decrypt the message using a memory stream
        byte[] benc = Convert.FromBase64String(base64Input);

        using (MemoryStream msDecrypt = new MemoryStream(benc))
        {
          // Get crypto stream for decrypted data
          CryptoStream csDecrypt = new CryptoStream(msDecrypt, _tdes.CreateDecryptor(_myKey, _myIV), CryptoStreamMode.Read);

          // Read the data out of the crypto stream
          byte[] bres = new byte[benc.Length + 1];
          csDecrypt.Read(bres, 0, benc.Length);
          // Convert to string
          sret = Encoding.ASCII.GetString(bres);
          // Clean up
          benc = null;
          bres = null;
          //csDecrypt.Close();
          //msDecrypt.Close();
        }
        _tdes.Clear();
      }

      // Return result
      return sret;
    }

    #endregion
  }
}
