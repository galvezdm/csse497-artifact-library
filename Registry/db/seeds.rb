#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

     #Clear the database
      Artifact.delete_all
      ArtifactCollection.delete_all
      ArtifactSearchIndex.delete_all
      User.delete_all
      PermissionGroup.delete_all


      #Test Users
      marsh = User.create! :first_name => "Fred", :last_name => "Marsh", :email => "fredmarsh@att.net", :password => 5,
                           :phone_number => "5555555555", :address => "42 Wallaby Way, Sydney", :city => "Terre Haute", :state => "IN",
                           :postal_code => "47803"
      marsh.save!()

      elmer = User.create! :first_name => "Elmer", :last_name => "Guerri", :email => "Eguerri@gmail.com", :password => 12345,
                           :phone_number => "5555555555", :address => "1234 Dinosaur Walk", :city => "Terre Haute", :state => "IN",
                           :postal_code => "47803"
      elmer.save!()

      nofriends = User.create! :first_name => "IHaveNo", :last_name => "Friends", :email => "foreveralone@gmail.com",
                               :password => 3, :phone_number => "5558675309", :address => "1 Loneliest Number", :city => "Longly",
                               :state => "IN", :postal_code => "47803"
      nofriends.save!()

      marsh.friends << elmer
      marsh.save!()

      #Test Permissions Groups
      permGroup = PermissionGroup.create! :name => "Aficionados", :owner => marsh
      permGroup.users << elmer
      permGroup.save!()

      #Initial Test Collection
     flint_collection = ArtifactCollection.create! :name => "Flint Collection", :owner => marsh, :universal => true
     flint_collection.permission_groups << permGroup
     flint_collection.keywords << "Arrowhead"
     flint_collection.keywords << "Arrowheads"
     flint_collection.keywords << "Flint"
     flint_collection.save!()

      mackinaw = Artifact.new universal: true
      mackinaw.owner = marsh
      flint_collection.artifacts << mackinaw
      mackinaw.name =  "Mackinaw Point"
      mackinaw.description = "A large point of the Snyders point cluster that has straight notches instead of rounded notches.  It has had one resharpening.  Found in Callaway Co., Mo."
      mackinaw.description.permission_groups << permGroup
      mackinaw.length=  "90 mm"
      mackinaw.width=  "57 mm"
      mackinaw.cultural_affiliation=  "Hopewell"
      mackinaw.previously_published=  "CSAJ 1997, #2, pg-56; Who's Who #6, 1984, p-50; Prehistoric American 1991, #4, p16-18"
      mackinaw.quality=  "High"
      mackinaw.discoverer=  "Dave Harvey"
      mackinaw.discovery_location = "Callaway Co., MO"
      mackinaw.creator=  "Hopewell Culture"
      mackinaw.creation_date= "100 B.C.-350 A.D."
      mackinaw.repairs=  "None"
      mackinaw.damaged_areas=  "None"
      mackinaw.authentication=  "Certificate from Gregory Perino"
      mackinaw.preservation_treatment=  "None"
      mackinaw.publication_reference = "Prehistoric American, 2001, No. 3, p. 21"
      mackinaw.technical_reports=  "CSAJ 1997, #2, p-56"
      mackinaw.miscellaneous=  "Artifact authenticated on July 4th, 1992"
      mackinaw.provenance << "John Smith"
      mackinaw.provenance << "George Thorogood"
      mackinaw.keywords << "Arrowhead"
      mackinaw.keywords << "Arrowheads"
      mackinaw.keywords << "Flint"
      mackinaw.save!()

      dalton = Artifact.new universal: true
      dalton.owner = marsh
      flint_collection.artifacts << dalton
      dalton.name = "Dalton Point"
      dalton.description=  "A large knife form that is made of multi-colored flint having gray, yellow, red, and orange colors"
      dalton.length=  "96 mm"
      dalton.width=  "33 mm"
      dalton.cultural_affiliation=  "Hopewell"
      dalton.previously_published=  "CSAJ 1997, #2, pg-56; Who's Who #6, 1984, p-50; Prehistoric American 1991, #4, p16-18"
      dalton.quality=  "High"
      dalton.discoverer =  "J. Clemens"
      dalton.discovery_location =  "Cooper Co.=  MO"
      dalton.creator=  "Hopewell Culture"
      dalton.creation_date = "Early Archaic period, 9,500 B.C."
      dalton.repairs=  "None"
      dalton.damaged_areas=  "None"
      dalton.authentication=  "Certificate from Gregory Perino"
      dalton.preservation_treatment=  "None"
      dalton.publication_reference =  "Legends of Prehistoric Art, vol. I, 2000, p. 88"
      dalton.technical_reports=  "None"
      dalton.miscellaneous=  "Artifact authenticated on March 18th, 2004"
      dalton.provenance <<  "John Smith"
      dalton.provenance << "George Thorogood"
      dalton.keywords << "Arrowhead"
      dalton.keywords << "Arrowheads"
      dalton.keywords << "Flint"
      dalton.save!()


      etley = Artifact.new universal: true
      etley.owner = marsh
      flint_collection.artifacts << etley
	    etley.name = "Etley point"
      etley.description = "A large knife form that was never resharpened.  Foundin Franklin Co., Mo."
      etley.length=  "161 mm"
      etley.width=  "57 mm"
      etley.cultural_affiliation=  "Hopewell"
      etley.previously_published=  "CSAJ 1956, #2, pg-52; Who's Who #4, 1976, p-22"
      etley.quality=  "High"
      etley.discoverer = "Dr. Paul F. Titterington"
      etley.discovery_location= "Franklin Co.=  MO"
      etley.creator=  "Hopewell Culture"
      etley.creation_date = "Late Archaic period, 2,000 B.C."
      etley.repairs=  "None"
      etley.damaged_areas=  "None"
      etley.authentication=  "Certificate from Gregory Perino"
      etley.preservation_treatment=  "None"
      etley.publication_reference=  "CSAJ 1987 #2, p-113"
      etley.technical_reports=  "CSAJ 1972, #3, p-139"
      etley.miscellaneous=  "Artifact authenticated on July 13th, 1992"
      etley.provenance << "John Smith"
      etley.provenance << "George Thorogood"
      etley.keywords << "Arrowhead"
      etley.keywords << "Arrowheads"
      etley.keywords << "Flint"
      etley.save!()

      barnes_fluted = Artifact.new :universal => true
      barnes_fluted.owner = marsh
      flint_collection.artifacts << barnes_fluted
      barnes_fluted.name = "Barnes Fluted Point"
      barnes_fluted.description = "A late Clovis form that has had one resharpening that has reduced the width and length ofthe blade slightly."
      barnes_fluted.length=  "88 mm"
      barnes_fluted.width=  "29 mm"
      barnes_fluted.cultural_affiliation=  "Clovis"
      barnes_fluted.previously_published = "Prehistoric American, 2001, No. 1, p. 26; Who's Who No. 9, 1996, p. 207 & 217"
      barnes_fluted.quality=  "High"
      barnes_fluted.discoverer=  "Stanley Grant"
      barnes_fluted.discovery_location = "Franklin Co.=  MO"
      barnes_fluted.creator=  "Clovis Culture"
      barnes_fluted.creation_date= "Paleo period, 11,000 B.C."
      barnes_fluted.repairs=  "None"
      barnes_fluted.damaged_areas=  "None"
      barnes_fluted.authentication=  "Certificate from Gregory Perino"
      barnes_fluted.preservation_treatment=  "None"
      barnes_fluted.publication_reference = "Who's Who No. 10, 2000, p. 213"
      barnes_fluted.technical_reports=  "None"
      barnes_fluted.miscellaneous=  "Artifact authenticated on July 27th, 1995"
      barnes_fluted.provenance << "John Smith"
      barnes_fluted.provenance << "George Thorogood"
      barnes_fluted.keywords << "Arrowhead"
      barnes_fluted.keywords << "Arrowheads"
      barnes_fluted.keywords << "Flint"
      barnes_fluted.keywords << "Fluted"
      barnes_fluted.keywords << "Barnes"
      barnes_fluted.save!()

      hardin = Artifact.new :universal => true
      hardin.owner = marsh
      flint_collection.artifacts << hardin
      hardin.name = "Hardin point"
      hardin.description = "A super Hardin point that has flake ridges lightly polished and a broad bevel of the cutting edges, which are serrated."
      hardin.length=  "148 mm"
      hardin.width=  "39 mm"
      hardin.cultural_affiliation=  "Hardin"
      hardin.previously_published = "Prehistoric Art, 1953, p. 87; The Redskin, 1997, No. 1; Tully's Book, 1986, P. 117"
      hardin.quality=  "High"
      hardin.discoverer=  "Kyle Sly"
      hardin.discovery_location =  "Lincoln Co.=  MO"
      hardin.creator=  "Hardin Culture"
      hardin.creation_date = "Early Archaic period, 8,500 B.C."
      hardin.repairs=  "None"
      hardin.damaged_areas=  "None"
      hardin.authentication=  "Certificate from Gregory Perino"
      hardin.preservation_treatment=  "None"
      hardin.publication_reference = "Masterpieces of Prehistoric Art, Vol 1., 2004, pp. 51 & 223; Prehistoric American 2006, No. 4, pp. 30 & 30-32"
      hardin.technical_reports=  "None"
      hardin.miscellaneous=  "Artifact authenticated on May 23rd, 1995"
      hardin.provenance << "John Smith"
      hardin.provenance << "George Thorogood"
      hardin.keywords << "Arrowhead"
      hardin.keywords << "Arrowheads"
      hardin.keywords << "Flint"
      hardin.save!()

      #Flint Collection Second Batch

      stanfield = Artifact.new :universal => true
      stanfield.owner = marsh
      flint_collection.artifacts << stanfield
      stanfield.name = "7-3/8\" Stanfield Knife"
      stanfield.description=  "An exceptionally fine blade having some use but 	was never resharpened"
      stanfield.length=  "184mm"
      stanfield.width=  "62mm"
      stanfield.cultural_affiliation=  "Stanfield"
      description = "Who’s Who No. 6, 1984, pp. 50 & 54."
      description = description + "\nCentral States Archaeological Journal, 1990, No. 4, p. 58."
      description = description + "\nWho’s Who No. 8, 1992, pp. 182, 187 & 190."
      description = description + "\nWho\’s Who No. 9, 1996, pp. 206, 207 & 208."
      description = description + "\nPrehistoric American Collectors Favorites 2002, No. 1, p. 34"
      description = description + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      description = description + "\nPrehistoric Antiquities & Archaeological News Quarterly, May 2012, Vol. 32, No. 2, p. 26."
      stanfield.previously_published = description
      stanfield.quality=  "High"
      stanfield.discoverer=  "John McKim"
      stanfield.discovery_location = "Callaway Co.,  MO"
      stanfield.creator=  "Stanfield Culture"
      stanfield.creation_date = "Early Archaic Period – 9640 to 8920 B.P."
      stanfield.repairs=  "None"
      stanfield.damaged_areas=  "None"
      stanfield.authentication=  "Certificate from Gregory Perino"
      stanfield.preservation_treatment=  "None"
      stanfield.publication_reference=  ""
      stanfield.technical_reports=  "None"
      stanfield.miscellaneous=  "Artifact Authenticated March 9th, 1996"
      stanfield.keywords << "Arrowhead"
      stanfield.keywords << "Flint"
      stanfield.keywords << "Arrowheads"
      stanfield.keywords << "Chert"
      stanfield.keywords << "Stanfield"
      stanfield.keywords << "Early Archaic"
      stanfield.keywords << "Archaic"
      stanfield.save!()

      #stanfield_photo  = File.open("seed_data/Stanfield Knife.jpg")
      ##stanfield.add_picture(stanfield_photo =  "Main Image"

      north = Artifact.new  :universal => false
      north.owner = marsh
      flint_collection.artifacts << north 
      north.name = "4-1/4\" North Point"
      north.send(DESCRIPTION, "A large preform for a Snyders point that is in fairly good condition.  A small repair is on the tip.")
      north.send(LENGTH, "104mm")
      north.send(WIDTH, "72mm")
      north.send(CULTURAL_AFFILIATION, "North")
      published = "Prehistoric American, 1991, No. 4, pp. 16 & 18."
      published = published + "\nPrehistoric American, 1992, No. 3, Inside Back Cover."
      published = published + "\nWho’s Who No. 8, 1992, pp. 141 & 142."
      published = published + "\nWho’s Who No. 9, 1996, p. 211."
      published = published + "\nWho’s Who No. 10, 2000, p. 208."
      published = published + "\nPrehistoric American 2002 Collector Favorites, No. 1, p. 34."
      published = published + "\nPrehistoric American 2005 Collectors’ Favorites, No. 1, p. 25."
      published = published + "\nPrehistoric American, 2006, No. 4, p, 30-2."
      north.send(PREVIOUSLY_PUBLISHED, published)
      north.send(QUALITY, "High")
      north.send(DISCOVERER, "Dr. Henry Milton Whelpley")
      north.send(DISCOVERY_LOCATION, "St. Louis Co., MO")
      north.send(CREATOR, "North Culture")
      north.send(CREATION_DATE, "Middle Woodland Period – 0 to A.D. 350.")
      north.send(RESTORATION_REPAIRS, "Small repair on tip")
      north.send(DAMAGED_AREAS, "None")
      north.send(AUTHENTICATION, "Certificate from Gregory Perino")
      north.send(PRESERVATION_TREATMENT, "None")
      north.send(PUBLICATION_REF, "")
      north.send(TECHNICAL_REPORTS, "None")
      north.send(MISCELLANEOUS, "Artifact Authenticated July 3rd, 1992")
      north.keywords << "Arrowhead"
      north.keywords << "Flint"
      north.keywords << "Arrowheads"
      north.keywords << "Chert"
      north.keywords << "North"
      north.keywords << "Middle Woodland"
      north.keywords << "Woodland"
      north.save!()

      #north_photo  = File.open("seed_data/North Point.jpg")
      #north.add_picture(north_photo , "Main Image")

      ramey = Artifact.new  :universal => false
      ramey.owner = marsh
      flint_collection.artifacts << ramey
      ramey.name = "8-1/4\" Ramey Knife"
      ramey.send(DESCRIPTION, "A large knife form that is exceptionally thin and 	well made.  It is in relatively unused condition.  Found in Lincoln Co., Mo.")
      ramey.send(LENGTH, "209mm")
      ramey.send(WIDTH, "48mm")
      ramey.send(CULTURAL_AFFILIATION, "Mississipian")
      published = "The Redskin, 1966, No. 2, p. 61."
      published = published + "\nCentral States Archaeological Journal, July 1978, No. 3, p. 114."
      published = published + "\nPrehistoric Art, 1980, No. 1, p. 38."
      published = published + "\nWho’s Who No. 6, 1984, pp. 40 & 41."
      published = published + "\nPrehistoric American, 1991, No. 4, p. 16."
      published = published + "\nWho’s Who No. 8, 1992, pp. 140 & 141."
      published = published + "\nPrehistoric American, 1994, No. 3, Back Cover."
      published = published + "\nPrehistoric American 1994 Classics, No. 4, p. 32."
      published = published + "\nWho’s Who No. 9, 1996, p. 216."
      published = published + "\nWho’s Who No. 10, 2000, p. 215."
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nOnken, B. & Pafford, J. T., Masterpieces of Prehistoric Art, Vol. 1, 2004, pp. 51 & 223."
      published = published + "\nPrehistoric American, 2006, No. 4, pp. 30 & 30-2."
      published = published + "\nPrehistoric American Collectors’ Favorites 2008, No. 1, p. 25."

      ramey.send(PREVIOUSLY_PUBLISHED, published)
      ramey.send(QUALITY, "High")
      ramey.send(DISCOVERER, "Roscoe Fiedler")
      ramey.send(DISCOVERY_LOCATION, "Lincoln Co., MO")
      ramey.send(CREATOR, "Ramey Culture")
      ramey.send(CREATION_DATE, "Middle Mississippian Period – A.D. 1000 to A.D. 1200.")
      ramey.send(RESTORATION_REPAIRS, "None")
      ramey.send(DAMAGED_AREAS, "None")
      ramey.send(AUTHENTICATION, "Certificate from Gregory Perino")
      ramey.send(PRESERVATION_TREATMENT, "None")
      ramey.send(PUBLICATION_REF, "")
      ramey.send(TECHNICAL_REPORTS, "None")
      ramey.send(MISCELLANEOUS, "Artifact Authenticated June 19th, 1992")
      ramey.keywords << "Arrowhead"
      ramey.keywords << "Flint"
      ramey.keywords << "Arrowheads"
      ramey.keywords << "Chert"
      ramey.keywords << "Ramey"
      ramey.keywords << "Middle Mississippian"
      ramey.keywords << "Mississippian"
      ramey.save!()

      #ramey_photo  = File.open("seed_data/Ramey Knife.jpg")
      #ramey.add_picture(ramey_photo , "Main Image")

      smith = Artifact.new  :universal => false
      smith.owner = marsh
      flint_collection.artifacts << smith
      smith.name = "6-0/0\" Smith Point"
      smith.send(DESCRIPTION, "A large knife form that is in used but unresharpened 	condition.")
      smith.send(LENGTH, "151mm")
      smith.send(WIDTH, "50mm")
      smith.send(CULTURAL_AFFILIATION, "")
      published = "Who’s Who No. 2, 1968, p. 122"
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nPrehistoric American Collector Favorites 2004, No. 1, p. 4."
      published = published + "\nOnken, B. & Pafford, J. T., Masterpieces of Prehistoric Art, Vol. 1, 2004, pp. 50 & 223."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      published = published + "\nBallinger, B. & L., Collectors of Historic & Prehistoric Artifacts, Vol. I, 2012, p. 128."
      smith.send(PREVIOUSLY_PUBLISHED, published)
      smith.send(QUALITY, "High")
      smith.send(DISCOVERER, "Maurice Meek")
      smith.send(DISCOVERY_LOCATION, "Madison Co., IL")
      smith.send(CREATOR, "")
      smith.send(CREATION_DATE, "Late Archaic Period – 2000 to 1000 B.C.")
      smith.send(RESTORATION_REPAIRS, "None")
      smith.send(DAMAGED_AREAS, "None")
      smith.send(AUTHENTICATION, "Certificate from Gregory Perino")
      smith.send(PRESERVATION_TREATMENT, "None")
      smith.send(PUBLICATION_REF, "")
      smith.send(TECHNICAL_REPORTS, "None")
      smith.send(MISCELLANEOUS, "Artifact Authenticated December 16th, 1999")
      smith.keywords << "Arrowhead"
      smith.keywords << "Flint"
      smith.keywords << "Arrowheads"
      smith.keywords << "Chert"
      smith.keywords << "Late Archaic"
      smith.keywords << "Archaic"
      smith.save!()

      #smith_photo  = File.open("seed_data/Smith Point.jpg")
      #smith.add_picture(smith_photo , "Main Image")

      stanfield2 = Artifact.new  :universal => false
      stanfield2.owner = marsh
      flint_collection.artifacts << stanfield2
      stanfield2.name = "10-0/0\" Stanfield Knife"
      stanfield2.send(DESCRIPTION, "A large knife form that is in rare and like new 	condition having been used but was never resharpened.  Most of these knives have at 	least half of the blade resharpened away.")
      stanfield2.send(LENGTH, "257mm")
      stanfield2.send(WIDTH, "66mm")
      stanfield2.send(CULTURAL_AFFILIATION, "Stanfield")
      published = "Prehistoric Artifacts of North America, 1986, Vol. XX, No. 1, p. 2."
      published = published + "\nWho’s Who No. 7, 1988, p. 136."
      published = published + "\nWho’s Who No. 9, 1996, pp. 206, 207 & 208."
      published = published + "\nWho’s Who No. 10, 2000, p. 212."
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nOnken, B. & Pafford, J. T., Masterpieces of Prehistoric Art, Vol. 1, 2004, pp. 50 & 223."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      published = published + "\nBallinger, B. & L., Collectors of Historic & Prehistoric Artifacts, Vol. I, 2012, p. 128."
      published = published + "\nPrehistoric American Collectors’ Favorites 2013, No. 1, p. 25."
      stanfield2.send(PREVIOUSLY_PUBLISHED, published)
      stanfield2.send(QUALITY, "High")
      stanfield2.send(DISCOVERER, "Harry \"Ken\" Kenworthy")
      stanfield2.send(DISCOVERY_LOCATION, "Boone Co., MO")
      stanfield2.send(CREATOR, "Stanfield Culture")
      stanfield2.send(CREATION_DATE, "Early Archaic Period – 9640 to 8920 B.P.")
      stanfield2.send(RESTORATION_REPAIRS, "None")
      stanfield2.send(DAMAGED_AREAS, "None")
      stanfield2.send(AUTHENTICATION, "Certificate from Gregory Perino")
      stanfield2.send(PRESERVATION_TREATMENT, "None")
      stanfield2.send(PUBLICATION_REF, "")
      stanfield2.send(TECHNICAL_REPORTS, "None")
      stanfield2.send(MISCELLANEOUS, "Artifact Authenticated May 19th, 1995")
      stanfield2.keywords << "Arrowhead"
      stanfield2.keywords << "Flint"
      stanfield2.keywords << "Arrowheads"
      stanfield2.keywords << "Chert"
      stanfield2.keywords << "Early Archaic"
      stanfield2.keywords << "Archaic"
      stanfield2.save!()

      #stanfield2_photo  = File.open("seed_data/Stanfield Knife 2.jpg")
      #stanfield2.add_picture(stanfield2_photo , "Main Image")

      snyders = Artifact.new  :universal => false
      snyders.owner = marsh
      flint_collection.artifacts << snyders
      snyders.name = "3-7/8\" Snyders Point"
      snyders.send(DESCRIPTION, "A large well made point that has had one resharpening.  It was found in an area with iron seeps that stained it.")
      snyders.send(LENGTH, "98mm")
      snyders.send(WIDTH, "61mm")
      snyders.send(CULTURAL_AFFILIATION, "Woodland")
      published = "Central States Archaeological Journal, 1972, No. 2, p. 90.."
      published = published + "\nCentral States Archaeological Journal, 1986, No. 4, p. 319."
      published = published + "\nPrehistoric American, 1991, No. 4, p. 18."
      published = published + "\nPrehistoric American, 1992, No. 3, Inside Back Cover."
      published = published + "\nWho’s Who No. 8, 1992, pp. 141 & 142."
      published = published + "\nPrehistoric American, 1994, No. 2, Front Cover."
      published = published + "\nPrehistoric American, 1994 Classics, No. 4, p. 32."
      published = published + "\nWho’s Who No. 9, 1996, p. 211."
      published = published + "\nWho’s Who No. 10, 2000, p. 208."
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nPrehistoric American Collectors’ Favorites 2005, No. 1, p. 25."
      published = published + "\nOnken, B., Legends of Prehistoric Art, Vol. I, 2000, pp. 61 (Bakutis), 114 & 115 (Fecht) & 209 (Smail)."
      published = published + "\nOnken, B., Legends of Prehistoric Art, Vol. II, 2011, p. 170 (Fecht)."
      snyders.send(PREVIOUSLY_PUBLISHED, published)
      snyders.send(QUALITY, "High")
      snyders.send(DISCOVERER, "William Smail")
      snyders.send(DISCOVERY_LOCATION, "Bond Co., MO")
      snyders.send(CREATOR, "Woodland Culture")
      snyders.send(CREATION_DATE, "Middle Woodland Period – 0 to A.D. 350.")
      snyders.send(RESTORATION_REPAIRS, "None")
      snyders.send(DAMAGED_AREAS, "None")
      snyders.send(AUTHENTICATION, "Certificate from Gregory Perino")
      snyders.send(PRESERVATION_TREATMENT, "None")
      snyders.send(PUBLICATION_REF, "")
      snyders.send(TECHNICAL_REPORTS, "None")
      snyders.send(MISCELLANEOUS, "Artifact Authenticated July 3rd, 1992")
      snyders.keywords << "Arrowhead"
      snyders.keywords << "Flint"
      snyders.keywords << "Arrowheads"
      snyders.keywords << "Chert"
      snyders.keywords << "Middle Woodland"
      snyders.keywords << "Woodland"
      snyders.save!()

      #snyders_photo  = File.open("seed_data/Snyders Point.jpg")
      #snyders.add_picture(snyders_photo , "Main Image")

      etley2 = Artifact.new  :universal => false
      etley2.owner = marsh
      flint_collection.artifacts << etley2
      etley2.name = "5-3/16\" Etley Point"
      etley2.send(DESCRIPTION, "A large knife form that is in relatively unused 	condition.")
      etley2.send(LENGTH, "147mm")
      etley2.send(WIDTH, "47mm")
      etley2.send(CULTURAL_AFFILIATION, "Etley")
      published = "Prehistoric American, 1991, No. 4, pp. 15, 17, & 18."
      published = published + "\nWho’s Who No. 8, 1992, pp. 141 & 143."
      published = published + "\nPrehistoric American, 1994 Classics, No. 4, p. 32."
      published = published + "\nWho’s Who No. 9, 1996, p. 209."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      published = published + "\nPrehistoric American Collectors’ Favorites 2013, No. 1, p. 25."
      etley2.send(PREVIOUSLY_PUBLISHED, published)
      etley2.send(QUALITY, "High")
      etley2.send(DISCOVERER, "Dale Scheperle")
      etley2.send(DISCOVERY_LOCATION, "Boone Co., MO")
      etley2.send(CREATOR, "Etley Culture")
      etley2.send(CREATION_DATE, "Late Archaic Period – 2000 B.C.")
      etley2.send(RESTORATION_REPAIRS, "None")
      etley2.send(DAMAGED_AREAS, "None")
      etley2.send(AUTHENTICATION, "Certificate from Gregory Perino")
      etley2.send(PRESERVATION_TREATMENT, "None")
      etley2.send(PUBLICATION_REF, "")
      etley2.send(TECHNICAL_REPORTS, "None")
      etley2.send(MISCELLANEOUS, "Artifact Authenticated June 18th, 1992")
      etley2.keywords << "Arrowhead"
      etley2.keywords << "Flint"
      etley2.keywords << "Arrowheads"
      etley2.keywords << "Chert"
      etley2.keywords << "Late Archaic"
      etley2.keywords << "Archaic"
      etley2.save!()

      #etley2_photo  = File.open("seed_data/Etley Point.jpg")
      #etley2.add_picture(etley2_photo , "Main Image")

      hardin1 = Artifact.new  :universal => false
      hardin1.owner = marsh
      flint_collection.artifacts << hardin1
      hardin1.name = "5-3/8\" Hardin Point"
      hardin1.send(DESCRIPTION, "A large knife form that 	has had one good resharpening that has 	reduced the size of the blade.")
      hardin1.send(LENGTH, "5-3/8 in.")
      hardin1.send(WIDTH, "")
      hardin1.send(CULTURAL_AFFILIATION, "Hardin")
      published = "Prehistoric American 1994 Classics, No. 4, Inside Back Cover."
      published = published + "\nWho’s Who No. 9, 1996, p. 209."
      published = published + "\nWho’s Who No. 10, 2000, p. 213."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      published = published + "\nPrehistoric American Collectors’ Favorites 2013, No. 1, p. 25."
      hardin1.send(PREVIOUSLY_PUBLISHED, published)
      hardin1.send(QUALITY, "High")
      hardin1.send(DISCOVERER, "Edward O. Buel")
      hardin1.send(DISCOVERY_LOCATION, "Boone Co., MO")
      hardin1.send(CREATOR, "Hardin Culture")
      hardin1.send(CREATION_DATE, "Early Archaic Period – 8500 B.P.")
      hardin1.send(RESTORATION_REPAIRS, "None")
      hardin1.send(DAMAGED_AREAS, "None")
      hardin1.send(AUTHENTICATION, "Certificate from Leonard A. Putty")
      hardin1.send(PRESERVATION_TREATMENT, "None")
      hardin1.send(PUBLICATION_REF, "")
      hardin1.send(TECHNICAL_REPORTS, "None")
      hardin1.send(MISCELLANEOUS, "Artifact Authenticated November 25th, 2012")
      hardin1.keywords << "Arrowhead"
      hardin1.keywords << "Flint"
      hardin1.keywords << "Arrowheads"
      hardin1.keywords << "Chert"
      hardin1.keywords << "Early Archaic"
      hardin1.keywords << "Archaic"
      hardin1.save!()

      #hardin1_photo  = File.open("seed_data/Hardin Point.jpg")
      #hardin1.add_picture(hardin1_photo , "Main Image")

      hardin2 = Artifact.new  :universal => false
      hardin2.owner = marsh
      flint_collection.artifacts << hardin2
      hardin2.name = "3-1/8\" Hardin Point"
      hardin2.send(DESCRIPTION, "A well made point that has had one minor 	resharpening that produced very fine serrations on blade edges.")
      hardin2.send(LENGTH, "79mm")
      hardin2.send(WIDTH, "42mm")
      hardin2.send(CULTURAL_AFFILIATION, "Hardin")
      published = "Who’s Who No. 7, 1988, p. 22."
      published = published + "\nPrehistoric American 1992, No. 3, Inside Back Cover."
      published = published + "\nWho’s Who No. 8, 1992, pp. 141 & 142."
      published = published + "\nPrehistoric American, 1993, No. 1, Back Cover."
      published = published + "\nWho’s Who No. 9, 1996, p. 210."
      published = published + "\nWho’s Who No. 10, 2000, p. 207."
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nPrehistoric American Collector Favorites 2003, No. 1, p. 21."
      published = published + "\nOnken, B. & Pafford, J. T., Masterpieces of Prehistoric Art, Vol. 1, 2004, pp. 62 & 226."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      hardin2.send(PREVIOUSLY_PUBLISHED, published)
      hardin2.send(QUALITY, "High")
      hardin2.send(DISCOVERER, "Gray R. LaDassor")
      hardin2.send(DISCOVERY_LOCATION, "St. Louis Co., MO")
      hardin2.send(CREATOR, "Hardin Culture")
      hardin2.send(CREATION_DATE, "Early Archaic Period – 8500 B.P.")
      hardin2.send(RESTORATION_REPAIRS, "None")
      hardin2.send(DAMAGED_AREAS, "None")
      hardin2.send(AUTHENTICATION, "Certificate from Gregory Perino")
      hardin2.send(PRESERVATION_TREATMENT, "None")
      hardin2.send(PUBLICATION_REF, "")
      hardin2.send(TECHNICAL_REPORTS, "None")
      hardin2.send(MISCELLANEOUS, "Artifact Authenticated June 8th, 1992")
      hardin2.keywords << "Arrowhead"
      hardin2.keywords << "Flint"
      hardin2.keywords << "Arrowheads"
      hardin2.keywords << "Chert"
      hardin2.keywords << "Early Archaic"
      hardin2.keywords << "Archaic"
      hardin2.save!()

      #hardin2_photo  = File.open("seed_data/Hardin Point 2.jpg")
      #hardin2.add_picture(hardin2_photo , "Main Image")

      hardin3 = Artifact.new  :universal => false
      hardin3.owner = marsh
      flint_collection.artifacts << hardin3
      hardin3.name = "4-9/16\" Hardin Point"
      hardin3.send(DESCRIPTION, "A large dart/knife form in used condition but was 	never resharpened.  It is exceptionally thin and fine for the type.")
      hardin3.send(LENGTH, "115mm")
      hardin3.send(WIDTH, "44mm")
      hardin3.send(CULTURAL_AFFILIATION, "Hardin")
      published = "Who’s Who No. 9, 1996, p. 210."
      published = published + "\nWho’s Who No. 10, 2000, p. 211."
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nOnken, B. & Pafford, J. T., Masterpieces of Prehistoric Art, Vol. 1, 2004, pp. 62 & 226."
      published = published + "\nPrehistoric American, 2002, No. 4, pp. 37 & 46."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      published = published + "\nPrehistoric American Collectors’ Favorites 2009, No. 1, p. 15."
      hardin3.send(PREVIOUSLY_PUBLISHED, published)
      hardin3.send(QUALITY, "High")
      hardin3.send(DISCOVERER, "George W Casteel")
      hardin3.send(DISCOVERY_LOCATION, "Butler Co., MO")
      hardin3.send(CREATOR, "Hardin Culture")
      hardin3.send(CREATION_DATE, "Early Archaic Period – 8500 B.P.")
      hardin3.send(RESTORATION_REPAIRS, "None")
      hardin3.send(DAMAGED_AREAS, "None")
      hardin3.send(AUTHENTICATION, "Certificate from Gregory Perino")
      hardin3.send(PRESERVATION_TREATMENT, "None")
      hardin3.send(PUBLICATION_REF, "")
      hardin3.send(TECHNICAL_REPORTS, "None")
      hardin3.send(MISCELLANEOUS, "Artifact Authenticated March 9th, 1996")
      hardin3.keywords << "Arrowhead"
      hardin3.keywords << "Flint"
      hardin3.keywords << "Arrowheads"
      hardin3.keywords << "Chert"
      hardin3.keywords << "Early Archaic"
      hardin3.keywords << "Archaic"
      hardin3.save!()

      #hardin3_photo  = File.open("seed_data/Hardin Point 3.jpg")
      #hardin3.add_picture(hardin3_photo , "Main Image")

      thebes = Artifact.new  :universal => false
      thebes.owner = marsh
      flint_collection.artifacts << thebes
      thebes.name = "3-7/8\" Thebes Point"
      thebes.send(DESCRIPTION, "A large knife form that has had one resharpening 	that resulted in forming light serrations and the beginning of beveled cutting edges.")
      thebes.send(LENGTH, "97mm")
      thebes.send(WIDTH, "43mm")
      thebes.send(CULTURAL_AFFILIATION, "Thebes")
      published = "Who’s Who No. 8, 1992, p. 146."
      published = published + "\nPrehistoric American, 1994 Classics, No. 4, Back Cover."
      published = published + "\nWho’s Who No. 9, 1996, p. 214."
      published = published + "\nPrehistoric American Collector Favorites 2002, No. 1, p. 34."
      published = published + "\nPrehistoric American Collector Favorites 2004, No. 1, p. 4."
      published = published + "\nPrehistoric American, 2006, No. 4, p. 30-2."
      thebes.send(PREVIOUSLY_PUBLISHED, published)
      thebes.send(QUALITY, "High")
      thebes.send(DISCOVERER, "Don Edwards")
      thebes.send(DISCOVERY_LOCATION, "Brown Co., IL")
      thebes.send(CREATOR, "Thebes Culture")
      thebes.send(CREATION_DATE, "Early Archaic Period – 748 to 7290 B.C.")
      thebes.send(RESTORATION_REPAIRS, "None")
      thebes.send(DAMAGED_AREAS, "None")
      thebes.send(AUTHENTICATION, "Certificate from Gregory Perino")
      thebes.send(PRESERVATION_TREATMENT, "None")
      thebes.send(PUBLICATION_REF, "")
      thebes.send(TECHNICAL_REPORTS, "None")
      thebes.send(MISCELLANEOUS, "Artifact Authenticated September 16th, 1992")
      thebes.keywords << "Arrowhead"
      thebes.keywords << "Flint"
      thebes.keywords << "Arrowheads"
      thebes.keywords << "Chert"
      thebes.keywords << "Early Archaic"
      thebes.keywords << "Archaic"
      thebes.save!()

      #thebes_photo  = File.open("seed_data/Thebes Point.jpg")
      #thebes.add_picture(thebes_photo , "Main Image")

