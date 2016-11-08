# unpack metadata
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-11-02 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_metadataInfo')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceInfo')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_lineage')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_distribution')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_associatedResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_additionalDocumentation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_funding')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Metadata

                    def self.unpack(hMetadata, responseObj)

                        # return nil object if input is empty
                        if hMetadata.empty?
                            responseObj[:readerExecutionMessages] << 'Metadata object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMetadata = intMetadataClass.newMetadata

                        # metadata - metadata info {metadataInfo} (required)
                        if hMetadata.has_key?('metadataInfo')
                            hObject = hMetadata['metadataInfo']
                            unless hObject.empty?
                                hReturn = MetadataInfo.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:metadataInfo] = hReturn
                                end
                            end
                        end
                        if intMetadata[:metadataInfo].empty?
                            responseObj[:readerExecutionMessages] << 'Metadata object is missing metadataInfo'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # metadata - resource info {resourceInfo} (required)
                        if hMetadata.has_key?('resourceInfo')
                            hObject = hMetadata['resourceInfo']
                            unless hObject.empty?
                                hReturn = ResourceInfo.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:resourceInfo] = hReturn
                                end
                            end
                        end
                        if intMetadata[:resourceInfo].empty?
                            responseObj[:readerExecutionMessages] << 'Metadata object is missing resourceInfo'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # metadata - resource lineage [] {lineage}
                        if hMetadata.has_key?('resourceLineage')
                            aItems = hMetadata['resourceLineage']
                            aItems.each do |item|
                                hReturn = ResourceLineage.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:lineageInfo] << hReturn
                                end
                            end
                        end

                        # metadata - resource distribution [] {distribution}
                        if hMetadata.has_key?('resourceDistribution')
                            aItems = hMetadata['resourceDistribution']
                            aItems.each do |item|
                                hReturn = Distribution.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:distributorInfo] << hReturn
                                end
                            end
                        end

                        # metadata - associated resource [] {associatedResource}
                        if hMetadata.has_key?('associatedResource')
                            aItems = hMetadata['associatedResource']
                            aItems.each do |item|
                                hReturn = AssociatedResource.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:associatedResources] << hReturn
                                end
                            end
                        end

                        # metadata - additional resource [] {additionalResource}
                        if hMetadata.has_key?('additionalDocumentation')
                            aItems = hMetadata['additionalDocumentation']
                            aItems.each do |item|
                                hReturn = AdditionalDocumentation.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:additionalDocuments] << hReturn
                                end
                            end
                        end

                        # metadata - funding [] {funding}
                        if hMetadata.has_key?('funding')
                            aItems = hMetadata['funding']
                            aItems.each do |item|
                                hReturn = Funding.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetadata[:funding] << hReturn
                                end
                            end
                        end

                        return intMetadata

                    end

                end

            end
        end
    end
end
