# ISO <<Class>> PT_Locale
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-21 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-07-28 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class PT_Locale

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hLocale, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('lan:PT_Locale') do

                     # locale - language (required)
                     s = hLocale[:languageCode]
                     unless s.nil?
                        @xml.tag!('lan:languageCode') do
                           codelistClass.writeXML('lan', 'iso_language', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(210, 'lan:languageCode', inContext)
                     end

                     # locale - character encoding (required)
                     s = hLocale[:characterEncoding]
                     unless s.nil?
                        @xml.tag!('lan:characterEncoding') do
                           codelistClass.writeXML('lan', 'iso_characterSet', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(211, 'lan:characterEncoding', inContext)
                     end

                  end

               end

            end

         end
      end
   end
end
