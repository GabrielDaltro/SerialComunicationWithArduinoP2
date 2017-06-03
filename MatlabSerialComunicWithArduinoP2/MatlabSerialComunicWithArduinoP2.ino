/* Autor: Gabriel Daltro Duarte
 * Data: 24 de maio de 2017
 * Local: João Pessoa, Paraíba, Brasil
 * 
 * Descrição: Esse programa recebe um número do Matlab através da porta Serial e produz uma resposta seguindo algum modelo matemático.
 * No Matlab, o par ordenado (excitação, resposta) será utilizado por uma rede Nerual para aprender o modelo matemática executado pelo arduino;
 * 
 */

byte in = 0.0; // Variável que armazena os dados recebidos do matlab 
byte out = 0.0;
byte InOut[20];
byte index = 0;
int i = 0;
byte LenthOfString = 0;

float floatDataReceiver;
String StringReceiver;

char concatCharReceiver[30];
char charReceiver = '0';

void setup() {
   //Configura a porta serial para a taxa de transmissão de 9600 bits/s
    Serial.begin (9600);

   // Envia o string "SIM" para o matlab para indicar que a porta serial já foi incializada
   //Ao reeber "SIM", o matlab sabe que já pode enviar e receber dados do arduino
    Serial.println ("SIM");     
}

void loop() {

   if (Serial.available() > 0) // Condição válida quando o arduino recebe algum byte
   {  
      //Serial.print ("AVB=");
      //Serial.println ( Serial.available() );
      while ( charReceiver != '*')
      {
        while (Serial.available() == 0) {} // Espera que o Buffer tenha algo para realizar a leitura
        charReceiver = Serial.read(); // Lê os dados recebidos 
        //Serial.print("charReceiver = "); 
        Serial.println(charReceiver);  
        //delay (100);    
        concatCharReceiver[i] = charReceiver;
        //Serial.print("i = ");
        //Serial.println(i);
        i++;
      }
      //Serial.println (i); 
      concatCharReceiver[i] = '\0';
      i = 0;
      //Serial.println(concatCharReceiver);
    StringReceiver = concatCharReceiver;
    floatDataReceiver = StringReceiver.toFloat() ;
    
    floatDataReceiver = 2*floatDataReceiver;
    
    Serial.println(floatDataReceiver);       
      
    }   
}
