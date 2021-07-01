# This script executes an EMLassemblyline workflow.

# Initialize workspace --------------------------------------------------------

# Update EMLassemblyline and load

# remotes::install_github("EDIorg/EMLassemblyline")
library(EMLassemblyline)

# Define paths for your metadata templates, data, and EML

path_templates <- "~/Documents/UMBS/stemmapsAA/metadata/templates"
path_data <- "~/Documents/UMBS/stemmapsAA/output"
path_eml <- "~/Documents/UMBS/stemmapsAA/output"

# Create metadata templates ---------------------------------------------------

# Below is a list of boiler plate function calls for creating metadata templates.
# They are meant to be a reminder and save you a little time. Remove the 
# functions and arguments you don't need AND ... don't forget to read the docs! 
# E.g. ?template_core_metadata

# Create core templates (required for all data packages)

EMLassemblyline::template_core_metadata(
  path = path_templates,
  license = "CC0",
  write.file = TRUE)

# Create table attributes template (required when data tables are present)

EMLassemblyline::template_table_attributes(
  path = path_templates,
  data.path = path_data,
  data.table = c("stemmaps.csv"))

# Create categorical variables template (required when attributes templates
# contains variables with a "categorical" class)

EMLassemblyline::template_categorical_variables(
  path = path_templates, 
  data.path = path_data)

# Create geographic coverage (required when more than one geographic location
# is to be reported in the metadata).

EMLassemblyline::template_geographic_coverage(
  path = path_templates, 
  data.path = path_data, 
  data.table = "stemmaps.csv", 
  site.col = "Site",
  empty=TRUE)

# Create taxonomic coverage template (Not-required. Use this to report 
# taxonomic entities in the metadata)

# remotes::install_github("EDIorg/taxonomyCleanr")
# library(taxonomyCleanr)
# 
# taxonomyCleanr::view_taxa_authorities()
# 
# EMLassemblyline::template_taxonomic_coverage(
#   path = path_templates, 
#   data.path = path_data,
#   taxa.table = "",
#   taxa.col = "",
#   taxa.name.type = "",
#   taxa.authority = 3)

# Make EML from metadata templates --------------------------------------------

# Once all your metadata templates are complete call this function to create 
# the EML.

Pid <- "edi.832.1"
Sid <- "edi.218.1"

EMLassemblyline::make_eml(
  path = path_templates,
  data.path = path_data,
  eml.path = path_eml, 
  dataset.title = "Stem maps of eight 1 ha forest plots distributed around Ann Arbor, MI and around the University of Michigan Biological Station (UMBS)", 
  temporal.coverage = c("2017-06-01", "2018-07-31"), 
  maintenance.description = "ongoing", 
  data.table = "stemmaps.csv", 
  data.table.name = "Tree Measurements",
  data.table.description = "Tree species and DBH census for 8 forest plots",
  other.entity = c("notebooks.zip", "raw.zip", "site_info.pdf"),
  other.entity.name = c("R Code", "Source", "Site location information"),
  other.entity.description = c("R scripts for data and metadata cleaning", "Source data for R scripts", "Further information about each site location"),
  user.id = "umbiologicalstat",
  user.domain = "EDI", 
  package.id = Pid)
