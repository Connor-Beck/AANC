function plotBarcode(barcode)
    for i=1:length(barcode)
        subplot(length(barcode),1,i);
        imshow(mat2gray(barcode{i}));
    end
end