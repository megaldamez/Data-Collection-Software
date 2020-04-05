function angle = readangle(a)
    position = 0;
    writeDigitalPin(a,'D5',1);
    writeDigitalPin(a,'D5',0);
    for i = 0:11
        writeDigitalPin(a,'D8',0);
        writeDigitalPin(a,'D8',1);
        bit = readDigitalPin(a,'D3');
        position = position + bit*(2^(12-(i+1)));
    end
    angle = position*360/(1023*4);
end