basic_mediation <- function(predictor, mediator, outcome, df){
  require(psych) #required for correlation tables 
  cor_object <- corr.test(df) #pearsons correlation and p-values 
  c_fit <- lm(reformulate(predictor,outcome), data = df)
  a_fit <- lm(reformulate(predictor,mediator), data = df) 
  c_prime_fit <- lm(reformulate(c(predictor,mediator),outcome), data = df)
  
  med_effect <- a_fit$coefficients[2]*c_prime_fit$coefficients[3]
  med_se <- (med_effect*sqrt(summary(a_fit)$coefficients[2,3]^2+summary(c_prime_fit)$coefficients[3,3]^2))/
    (summary(a_fit)$coefficients[2,3]*summary(c_prime_fit)$coefficients[3,3])
  med_z <- med_effect/med_se
  med_p <- 2*pnorm(-abs(med_z))
  med_ci <- 1.96*med_se
  
  results <- list(cor_matrix = list(cor_r = cor_object$r, cor_p = cor_object$p),
                  "c_path: Y~X" = as.data.frame(summary(c_fit)$coefficients, row.names = c("(intercept)",predictor)), 
                  "a_path: M~X" = as.data.frame(summary(a_fit)$coefficients, row.names = c("(intercept)",mediator)),
                  "c_prime_path Y~X+M" = as.data.frame(summary(c_prime_fit)$coefficients, row.names = c("(intercept)", predictor, mediator)),
                  "model_summary" = data.frame(indirect_effect = med_effect, 
                                               se = med_se, 
                                               sobels_z = med_z, 
                                               p_value = med_p, 
                                               confint_value = med_ci,
                                               confint_lower = med_effect-med_ci,
                                               confint_upper = med_effect+med_ci,
                                               row.names = "")
  )
  return(results)
}