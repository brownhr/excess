
xs_area <- function(xs) {
  # Mutate the InvertRod to be relative to Bankful;
  # This can easily be appended to also calculate area relative to another
  # feature, such as WS or whatever else.
  
  
  # Set values of InvertRod > Bankful equal to Bankful, then normalize the
  # whole dataset such that Bankful = 0 (baseline)
  
  xs <- xs %>%
    dplyr::mutate(InvertRod_Bankful = (pmin(InvertRod, Bankful) - Bankful))
  
  
  # Approximate integration using trapezoidal rule with basepoints at x = xs$TAPE
  area <- abs(pracma::trapz(x = xs$TAPE,
                            y = xs$InvertRod_Bankful))
  return(area)
}