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

transformed data {
    real default_intercept = 50;
    real c = 850; // maximum CT numer
}

parameters {
    vector[9] b;
    vector<lower=0>[5] sigma;
    vector[N_patient] r_b;
    vector<lower=0>[N_patient] intercept;
    real<lower=0> sigma_b;
}

transformed parameters {
    vector[N_patient] a;
    vector[N] b_x;
    vector[N] sigmoid;

    for (n in 1:N_patient) {
        a[n] = (c - intercept[n]) / intercept[n];
    }
    for (n in 1:N) {
        b_x[n] = (b[1] + r_b[Idx_patient[n]]) * FD[n] +
                  b[2] * Sex[n] +
                  b[3] * Age_40[n] +
                  b[4] * Age_50[n] +
                  b[5] * Age_60[n] +
                  b[6] * Operator_1[n] +
                  b[7] * Operator_2[n] +
                  b[8] * Operator_3[n] +
                  b[9] * Operator_4[n];
        sigmoid[n] = c / (1 + (a[Idx_patient[n]] * exp(-1 * b_x[n])));
    }
}

model {
    intercept ~ normal(default_intercept, 25);
    r_b ~ normal(0, sigma_b);
    b[1] ~ normal(0.1, 0.05);
    b[2] ~ normal(0, 0.05);
    b[3] ~ normal(0, 0.05);
    b[4] ~ normal(0, 0.05);
    b[5] ~ normal(0, 0.05);
    b[6] ~ normal(0, 0.05);
    b[7] ~ normal(0, 0.05);
    b[8] ~ normal(0, 0.05);
    b[9] ~ normal(0, 0.05);
    sigma ~ student_t(4, 0, 50);
    sigma_b ~ student_t(4, 0, 0.1);
    CTnumber ~ normal(sigmoid, sigma[Idx_operator]);
}
