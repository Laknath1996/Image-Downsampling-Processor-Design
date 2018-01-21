b=imresize(imread('input.jpg'),[512,512]); % 24-bit jpg image RGB888 
%resized to 512*512 as an initial step

k=1;
for i=512:-1:1
    for j=1:512
        a(k)=b(i,j,1);
        a(k+1)=b(i,j,2);
        a(k+2)=b(i,j,3);
        k=k+3;
    end
end

totalpixels = 512*512;

serial_port = serial('com3'); %port creation
Set (serial_port, 'BaudRate',9600)
Set (serial_port, 'InputBufferSize', totalpixels)
Set (serial_port, 'OutputBufferSize', totalpixels)

%Writing and reading to/from the port
fopen(serial_port); %opens the port 
fwrite(serial_port, dec2hex(bin2dec(a))); %writing hex data

%reading the processed image
A= fread (serial_port, n); %reading binary data,n indicates no. of data

%Closing serial port
Delete (serial);
Clear (serial);