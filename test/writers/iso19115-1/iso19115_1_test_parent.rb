# MdTranslator - minitest of
# parent class for all tc_19115_1 tests

# History:
# Stan Smith 2019-04-11 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'nokogiri'
require 'adiwg-mdjson_schemas'
require 'adiwg/mdtranslator'

class TestWriter191151Parent < MiniTest::Test

   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # get fgdc XML for test reference from resultXML folder
   def self.get_xml(fileName)
      file = File.join(File.dirname(__FILE__), 'testData', fileName) + '.xml'
      xDoc = Nokogiri::XML(File.read(file))
      return xDoc
   end

   # test schema for reader modules
   def self.testSchema(mdJson, schema, fragment: nil, remove: [])

      # load all schemas with 'true' to prohibit additional parameters
      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # load schema segment and make all elements required and prevent additional parameters
      strictSchema = ADIWG::MdjsonSchemas::Utils.load_strict(schema)

      # remove unwanted parameters from the required array
      unless remove.empty?
         strictSchema['required'] = strictSchema['required'] - remove
      end

      # build relative path to schema fragment
      fragmentPath = nil
      if fragment
         fragmentPath = '#/definitions/' + fragment
      end

      # scan
      return JSON::Validator.fully_validate(strictSchema, mdJson, :fragment => fragmentPath)

   end

   def self.run_test(hIn, expectFile, expectPath, gotPath, gotSuffix = 0)

      # read the fgdc reference file
      xFile = get_xml(expectFile)
      xExpect = xFile.xpath(expectPath)
      expect = xExpect.to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'iso19115_1', showAllTags: true, validate: 'none'
      )
      pass = hResponseObj[:writerPass] &&
         hResponseObj[:readerStructurePass] &&
         hResponseObj[:readerValidationPass] &&
         hResponseObj[:readerExecutionPass]

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      # TODO remove write
      #File.write('/mnt/hgfs/ShareDrive/writeOut.xml', xMetadata)
      xGot = xMetadata.xpath(gotPath)[gotSuffix]
      got = xGot.to_s.squeeze(' ')

      return expect, got, pass, hResponseObj[:writerMessages]

   end

end
