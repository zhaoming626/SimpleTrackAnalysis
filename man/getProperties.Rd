\name{getProperties}
\alias{getProperties}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Get Properties
%%  ~~function to do ... ~~
}
\description{
Get detailed track properties
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
getProperties()
}
%- maybe also 'usage' for other objects documented here.
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
Ming Zhao
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
function () 
{
    length <- length(trackSample)
    starttime <- trackSample$time[1]
    endtime <- trackSample$time[length]
    startpoint <- c(trackSample$longitude[1], trackSample$latitude[1])
    endpoint <- c(trackSample$longitude[length], trackSample$latitude[length])
    distance <- distHaversine(startpoint, endpoint)
    speedMean <- mean(trackSample$Speed.km.h., na.rm = T)
    altitudeMean <- mean(trackSample$GPS.Altitude.m., na.rm = T)
    rpmMean <- mean(trackSample$Rpm.u.min., na.rm = T)
    result <- list(starttime = starttime, endtime = endtime, 
        distance = distance, speedMean = speedMean, altitudeMean = altitudeMean, 
        rpmMean = rpmMean)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
