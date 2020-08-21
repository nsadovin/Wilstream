using System;

namespace ConsoleAppTest
{
    class Program
    {
        static void Main(string[] args)
        {
            var a = "FG-001".ToCharArray();
            Increment(a);
            Console.WriteLine(new String(a));
            Console.ReadKey();
        }



        static void Increment(char[] refernceNumber)
        { 
            for (int i = refernceNumber.Length-1; i >= 0; i--)
            {
                int current;
                if (int.TryParse(refernceNumber[i].ToString(), out current))
                {
                    current++;
                    if (current > 9)
                    {
                        refernceNumber[i] = '0'; 
                    }
                    else
                    {
                        refernceNumber[i] = current.ToString()[0]; 
                        return;
                    }
                }
                else
                {
                    return;
                }
            }
        }
    }
}
