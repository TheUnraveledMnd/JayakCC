require('Jayak.Core.Class')

DigitalRedstoneTransceiver = Class:extend({ __name = 'Jayak.Core.DigitalRedstoneTransceiver' })

function DigitalRedstoneTransceiver:new(device, face)
    DigitalRedstoneTransceiver.__super.new(self)
    self.__state.device = device
    self.__state.face = face
end

function DigitalRedstoneTransceiver:device()
    return self.__state.device
end

function DigitalRedstoneTransceiver:face()
    return self.__state.face
end

function DigitalRedstoneTransceiver:isOff()
    return not self:isOn()
end

function DigitalRedstoneTransceiver:isOn()
    return self:device().getOutput(self:face())
end

function DigitalRedstoneTransceiver:off()
    self:device().setOutput(self:face(), false)

function DigitalRedstoneTransceiver:on()
    self:device().setOutput(self:face(), true)
end
