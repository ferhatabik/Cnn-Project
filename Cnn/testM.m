function [value] = testM(testImage, weight, filter)
%elde etti�imiz de�erlerin 0-1 aral���nda olmamas�ndan dolay�
%hangisini alaca��m�z konusunda emin olamad�k. 
%bu durumda en b�y�k de�ere sahip olan outputun index de�erini 
%tahmin olarak d�nd�r�yoruz.
conv2ed = conv2(testImage,filter,'valid');

dlX = dlarray(conv2ed, 'SSCB');

[pooling_Matrix, indx, dataSize] = maxpool(dlX,4,'Stride',4);

y = extractdata(pooling_Matrix);
flattening = reshape(y,[],1);
Vs = weight * flattening;

softmaxVs = softmax(Vs);

maximum = max(max(softmaxVs));
[x,y]=find(softmaxVs==maximum);
value = x;
end

