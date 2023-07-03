# ISO 19115-3 <<Class>> MI_Metadata
# 19115-3 writer output in XML.

# History:
#  Stan Smith 2018-05-03 add variable for changing XSD location
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2018-01-27 add metadata constraints
#  Stan Smith 2016-11-15 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-08-27 added support for content information
#  Stan Smith 2015-07-30 added support for grid information
#  Stan Smith 2015-07-28 added support for PT_Locale
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of Iso19115_3 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-12 added support for user to specify metadataCharacterSet
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-29 set builder object '@xml' into string 'metadata'
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-11-06 changed hierarchy level to load values from resourceInfo > resourceType
#  Stan Smith 2014-10-10 modified to pass minimum metadata input test
#   ... test were added to handle a missing metadata > metadataInfo block in the input
#  Stan Smith 2014-10-07 changed source of dataSetURI to
#   ... metadata: {resourceInfo: {citation: {citOlResources[0]: {olResURI:}}}}
#  Stan Smith 2014-09-19 changed file identifier to read from internal storage as
#   ... an MD_Identifier class.  To support version 0.8.0 json.
#  Stan Smith 2014-09-03 replaced spatial reference system code with named, epsg, and
#   ... wkt reference system descriptions using RS_Identifier for 0.7.0
#  Stan Smith 2014-08-18 add dataSetURI
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-28 added resource URI
#  Stan Smith 2014-05-14 refactored method calls to be consistent w/ other classes
#  Stan Smith 2014-05-14 modify for JSON schema 0.4.0
# 	Stan Smith 2013-12-27 added parent identifier
# 	Stan Smith 2013-09-25 added reference system info
# 	Stan Smith 2013-09-25 added metadata maintenance
# 	Stan Smith 2013-09-25 added data quality
# 	Stan Smith 2013-09-25 added distribution
# 	Stan Smith 2013-08-09 original script
# RobertSearch


require 'uuidtools'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative '../iso19115_3_writer'
require_relative 'class_codelist'
# require_relative 'class_hierarchy'
# require_relative 'class_responsibleParty'
# require_relative 'class_locale'
# require_relative 'class_spatialRepresentation'
# require_relative 'class_referenceSystem'
# require_relative 'class_extension'
# require_relative 'class_dataIdentification'
# require_relative 'class_coverageDescription'
# require_relative 'class_distribution'
# require_relative 'class_dataQuality'
# require_relative 'class_useConstraints'
# require_relative 'class_legalConstraints'
# require_relative 'class_securityConstraints'
# require_relative 'class_maintenance'
# require_relative 'class_gcoDateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MI_Metadata

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(intObj)

                  # classes used
                  intMetadataClass = InternalMetadata.new
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  # partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  # hierarchyClass = Hierarchy.new(@xml, @hResponseObj)
                  # localeClass = PT_Locale.new(@xml, @hResponseObj)
                  # representationClass = SpatialRepresentation.new(@xml, @hResponseObj)
                  # systemClass = MD_ReferenceSystem.new(@xml, @hResponseObj)
                  # extensionClass = MD_MetadataExtensionInformation.new(@xml, @hResponseObj)
                  # dataIdClass = MD_DataIdentification.new(@xml, @hResponseObj)
                  # coverageClass = CoverageDescription.new(@xml, @hResponseObj)
                  # distClass = MD_Distribution.new(@xml, @hResponseObj)
                  # dqClass = DQ_DataQuality.new(@xml, @hResponseObj)
                  # uConClass = MD_Constraints.new(@xml, @hResponseObj)
                  # lConClass = MD_LegalConstraints.new(@xml, @hResponseObj)
                  # sConClass = MD_SecurityConstraints.new(@xml, @hResponseObj)
                  # maintenanceClass = MD_MaintenanceInformation.new(@xml, @hResponseObj)
                  # dateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                  # create shortcuts to sections of internal object
                  hMetadata = intObj[:metadata]
                  hMetaInfo = hMetadata[:metadataInfo]
                  hResInfo = hMetadata[:resourceInfo]
                  aDistInfo = hMetadata[:distributorInfo]
                  version = @hResponseObj[:translatorVersion]

                  # document head
                  metadata = @xml.instruct! :xml, encoding: 'UTF-8'
                  @xml.comment!('ISO 19115-3 METADATA DRAFT API')
                  @xml.comment!('This metadata record was generated by mdTranslator ' + version + ' at ' + Time.now.to_s)

                  # schema locations
                  # set to 'remoteSchema' before publishing
                  localSchema = 'C:\Users\StanSmith\Projects\ISO\19115\NOAA\schema.xsd'
                  remoteSchema = 'https://schemas.isotc211.org/19115/-3/mdb/2.0/mdb.xsd'

                  # MI_Metadata
                  @xml.tag!('mdb:MD_Metadata',
                            {'xmlns:mdb' => 'http://standards.iso.org/iso/19115/-3/mdb/2.0',
                              'xmlns:cat' => 'http://standards.iso.org/iso/19115/-3/cat/1.0',
                              'xmlns:gfc' => 'http://standards.iso.org/iso/19110/gfc/1.1',
                              'xmlns:cit' => 'http://standards.iso.org/iso/19115/-3/cit/2.0',
                              'xmlns:gcx' => 'http://standards.iso.org/iso/19115/-3/gcx/1.0',
                              'xmlns:gex' => 'http://standards.iso.org/iso/19115/-3/gex/1.0',
                              'xmlns:lan' => 'http://standards.iso.org/iso/19115/-3/lan/1.0',
                              'xmlns:srv' => 'http://standards.iso.org/iso/19115/-3/srv/2.1',
                              'xmlns:mas' => 'http://standards.iso.org/iso/19115/-3/mas/1.0',
                              'xmlns:mcc' => 'http://standards.iso.org/iso/19115/-3/mcc/1.0',
                              'xmlns:mco' => 'http://standards.iso.org/iso/19115/-3/mco/1.0',
                              'xmlns:mda' => 'http://standards.iso.org/iso/19115/-3/mda/1.0',
                              'xmlns:mds' => 'http://standards.iso.org/iso/19115/-3/mds/2.0',
                              'xmlns:mdt' => 'http://standards.iso.org/iso/19115/-3/mdt/2.0',
                              'xmlns:mex' => 'http://standards.iso.org/iso/19115/-3/mex/1.0',
                              'xmlns:mmi' => 'http://standards.iso.org/iso/19115/-3/mmi/1.0',
                              'xmlns:mpc' => 'http://standards.iso.org/iso/19115/-3/mpc/1.0',
                              'xmlns:mrc' => 'http://standards.iso.org/iso/19115/-3/mrc/2.0',
                              'xmlns:mrd' => 'http://standards.iso.org/iso/19115/-3/mrd/1.0',
                              'xmlns:mri' => 'http://standards.iso.org/iso/19115/-3/mri/1.0',
                              'xmlns:mrl' => 'http://standards.iso.org/iso/19115/-3/mrl/2.0',
                              'xmlns:mrs' => 'http://standards.iso.org/iso/19115/-3/mrs/1.0',
                              'xmlns:msr' => 'http://standards.iso.org/iso/19115/-3/msr/2.0',
                              'xmlns:mdq' => 'http://standards.iso.org/iso/19157/-2/mdq/1.0',
                              'xmlns:mac' => 'http://standards.iso.org/iso/19115/-3/mac/2.0',
                              'xmlns:gco' => 'http://standards.iso.org/iso/19115/-3/gco/1.0',
                              'xmlns:gml' => 'http://www.opengis.net/gml/3.2',
                             'xmlns:xlink' => 'http://www.w3.org/1999/xlink',
                             'xmlns:geonet' => 'http://www.fao.org/geonetwork',
                             'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                             'xsi:schemaLocation' => "http://standards.iso.org/iso/19115/-3/mdb/2.0 #{remoteSchema}"}) do

                     # metadata information - file identifier (default: UUID)
                     s = hMetaInfo[:metadataIdentifier][:identifier]

                     # metadata information - metadata character ('utf-8')
                     @xml.tag!('lan:characterEncoding') do
                        codelistClass.writeXML('lan', 'iso_characterSet', 'utf8')
                     end
                     # metadata information - metadata language ('eng; USA')
                     @xml.tag!('gmd:language') do
                        @xml.tag!('gco:CharacterString', 'eng; USA')
                     end

                     # metadata information - parent identifier
                     s = nil
                     hParent = hMetaInfo[:parentMetadata]


                  end # gmi:MI_Metadata tag

                  return metadata

               end # writeXML
            end # MI_Metadata class

         end
      end
   end
end
