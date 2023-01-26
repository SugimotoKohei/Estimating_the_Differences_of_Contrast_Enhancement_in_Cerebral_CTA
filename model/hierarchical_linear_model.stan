data {
    int N;                                // num of sample size
    int N_patient;                        // num of patients
    int<lower=1> Idx_patient[N];          // indices of patients
    int<lower=1,upper=5> Idx_operator[N]; // indices of CT operators
    vector[N] CTnumber;                   // data of mean CT numbers
    vector[N] FD;                         // data of fractional dose
    int<lower=0, upper=1> Sex[N];         // dummy variables for sex
    int<lower=0, upper=1> Age_40[N];      // dummy variables for under 40s
    int<lower=0, upper=1> Age_50[N];      // dummy variables for 50s
    int<lower=0, upper=1> Age_60[N];      // dummy variables for 60s
    int<lower=0, upper=1> Operator_1[N];  // dummy variables for CT operator 1
    int<lower=0, upper=1> Operator_2[N];  // dummy variables for CT operator 2
    int<lower=0, upper=1> Operator_3[N];  // dummy variables for CT operator 3
    int<lower=0, upper=1> Operator_4[N];  // dummy variables for CT operator 4
}

parameters {
    vector[9] b;
    vector<lower=0>[5] sigma;
    vector[N_patient] intercept;
    real mean_intercept;
    vector[N_patient] r_patient;
    real<lower=0> sigma_intercept;
    real<lower=0> sigma_patient;
}

transformed parameters {
    vector[N] mu;

    for (n in 1:N) {
            mu[n] = intercept[Idx_patient[n]] + (b[1] + r_patient[Idx_patient[n]]) * FD[n] +
                                                 b[2] * Sex[n] +
                                                 b[3] * Age_40[n] +
                                                 b[4] * Age_50[n] +
                                                 b[5] * Age_60[n] +
                                                 b[6] * Operator_1[n] +
                                                 b[7] * Operator_2[n] +
                                                 b[8] * Operator_3[n] +
                                                 b[9] * Operator_4[n];
    }
}

model {
    intercept ~ normal(mean_intercept, sigma_intercept);
    r_patient ~ normal(0, sigma_patient);
    CTnumber ~ normal(mu, sigma[Idx_operator]);
}
