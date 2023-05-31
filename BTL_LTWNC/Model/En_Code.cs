using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace BTL_LTWNC.Model
{
    public class En_Code
    {
        public string ToEnCodeHashCode(string str)
        {
            string key = "MahOaMatKhauBaoMatvODOi";

            string text = "";
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(str);
            byte[] hasData = new MD5CryptoServiceProvider().ComputeHash(temp);

            var secretKeyBytes = new MD5CryptoServiceProvider().ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider();
            tripDes.Key = secretKeyBytes;
            tripDes.Mode = CipherMode.ECB;
            tripDes.Padding = PaddingMode.PKCS7;
            ICryptoTransform transform = tripDes.CreateEncryptor();
            byte[] arrResult = transform.TransformFinalBlock(hasData, 0, hasData.Length);

            text = Convert.ToBase64String(arrResult, 0, arrResult.Length);

            return text;
        }
    }
}