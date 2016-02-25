# SimpleTrackAnalysis
The purpose of this OpenCPU app is to demonstrate how to use the opencpu.js library for calling R functions from Javascript using OpenCPU.

Use locally

To run the app in your local R session:

#install app
library(devtools)

install_github("SimpleTrackAnalysis", "zhaoming626")


#load in opencpu
library(opencpu)

opencpu$browse("/library/demo/www")