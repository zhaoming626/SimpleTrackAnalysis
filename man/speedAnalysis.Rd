\name{speedAnalysis}
\alias{speedAnalysis}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
simple analysis a sample track
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
speedAnalysis(minSpeed)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{minSpeed}{
%%     ~~Describe \code{minSpeed} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (minSpeed) 
{
    library(plot3D)
    trackSample <- read.csv("sample.csv")
    filterFlag <- trackSample$Speed.km.h. >= minSpeed
    filterResult <- trackSample[filterFlag, ]
    with(filterResult, text2D(x = longitude, y = latitude, colvar = Speed.km.h., 
        xlab = "longitude", ylab = "latitude", clab = "Speed(km/h)", 
        main = paste("Track Dataset Size:", length(rownames(filterResult)), 
            sep = " "), font = 3, labels = rownames(filterResult)))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
