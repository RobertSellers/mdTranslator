# unpack vertical measure
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-16 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module VerticalMeasure

                    def self.unpack(hVertical, responseObj)

                        # return nil object if input is empty
                        if hVertical.empty?
                            responseObj[:readerExecutionMessages] << 'Vertical Measure object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intVertical = intMetadataClass.newVerticalMeasure

                        # distance measure - distance (required)
                        if hVertical.has_key?('verticalDistance')
                            intVertical[:verticalDistance] = hVertical['verticalDistance']
                        end
                        if intVertical[:verticalDistance].nil? || intVertical[:verticalDistance] == ''
                            responseObj[:readerExecutionMessages] << 'Distance Measure attribute distance is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # distance measure - unit of measure {identifier}
                        if hVertical.has_key?('unitOfMeasure')
                            intVertical[:unitOfMeasure] = hVertical['unitOfMeasure']
                        end
                        if intVertical[:unitOfMeasure].nil? || intVertical[:unitOfMeasure] == ''
                            responseObj[:readerExecutionMessages] << 'Distance Measure attribute unitOfMeasure is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intVertical
                    end

                end

            end
        end
    end
end
