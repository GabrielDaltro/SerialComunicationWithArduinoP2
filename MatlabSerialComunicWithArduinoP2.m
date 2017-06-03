%Autor: Gabriel Daltro Duarte
%Data: 24/05/2017
%Local: João Pessoa, Paraíba - Brasil


%Descrição: Esse script envia um número para o arduino através da porta
%serial e recebe um número como resposta, o par excitação-resposta é
%armazenado em um vetor. Esse processo se repete várias vezes até que se
%tenha uma grande quantiade de pares ordenados que serão utilizados para o
%treinamento de uma Rede Neural Artificial; 

    fclose (porta_serial);
    
    clc;
    
    %Dados a serem enviados ao Arduino no formato double    
    for i = 1:10
        dataInArduinoDouble(i) = i*1.1;
    end
     dataInArduinoDouble(1) = 115.123;

    porta_serial = serial ('COM5', 'BaudRate', 9600);

    fopen(porta_serial);

    %Aguarda que o Arduino envie o string 'SIM' indicando que sua porta serial
    %foi incicializada
    while ( (strcmp (fscanf(porta_serial,'%s'),'SIM')) == 0 ) 
       %disp ('Esperando SIM');
    end
   
    
    flushinput(porta_serial); %limpa o buffer da porta serial
    
    dataInArduinoString = num2str(dataInArduinoDouble(1),10); %Converte o numero double a ser enviado em string
       
    %for i = 1:length(dataInArduinoString)
    %    fwrite(porta_serial,dataInArduinoString(i),'char'); 
    %end
    %fwrite(porta_serial,'c','char'); 
    
    fprintf (porta_serial,'%s*',dataInArduinoString); %Envia o string para o Matlab
    disp ( 'Enviei: '); %Exibe o string enviado
    disp(dataInArduinoString);
    
    a = '0';
    while (a ~= '*')
     
       % while ( porta_serial.BytesAvailable < 0 ) %aguarda a resposta do Arduino
       % end
       
       if ( porta_serial.BytesAvailable > 0 )
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          a = fscanf(porta_serial,'%s'); %Exibe o string enviado pelo arduino
          disp ( 'Recebi: ');
          disp( a );
       end
    end
    
    a = fscanf(porta_serial,'%s'); %Exibe o string enviado pelo arduino
    disp ( 'Recebi: ');
    disp( a );
    
    fclose(porta_serial);

