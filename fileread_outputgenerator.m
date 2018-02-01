output=fopen('output.txt','r');

t=textscan(output,'%2s');
table=t{1,:};

%array
tablefinal=zeros(40000,1);

for i=1:40000
    tablefinal(i,1)=hex2dec(table{i});
end

M=uint8(reshape(tablefinal,200,200));
imshow(M);