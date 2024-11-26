<script setup lang="ts">
import { ref } from "vue";

const curDate = new Date();

const initialSalary = ref(35000);
const companyContributionRate = ref(0.05);
const employeeContributionRate = ref(0.03);
const salaryIncreaseRate = ref(0.03);
const annualReturnRate = ref(0.01);
const startMonth = ref(curDate.getMonth() + 1);
const endMonth = ref(curDate.getMonth() + 1);
const startYear = ref(curDate.getFullYear());
const endYear = ref(curDate.getFullYear() + 30);
const initialFund = ref(0);

const lastSalary = ref(0);
const totalFund = ref(0);

function calculateProvidentFund(
    initialSalary: number,
    companyContributionRate: number,
    employeeContributionRate: number,
    salaryIncreaseRate: number,
    annualReturnRate: number,
    startMonth: number,
    endMonth: number,
    startYear: number,
    endYear: number,
    initialFund: number
) {
    const monthlyContributionRate =
        companyContributionRate + employeeContributionRate;
    const monthsInYear = 12;

    let currentSalary = initialSalary;
    let totalMonths =
        (endYear - startYear) * monthsInYear + (endMonth - startMonth);

    for (let month = 1; month <= totalMonths; month++) {
        const monthlyContribution = currentSalary * monthlyContributionRate;
        initialFund += monthlyContribution;

        if (month % monthsInYear === 0) {
            initialFund *= 1 + annualReturnRate;
        }

        if (month % monthsInYear === 3) {
            currentSalary *= 1 + salaryIncreaseRate;
        }
    }
    totalFund.value = initialFund;
    lastSalary.value = currentSalary;

    return initialFund;
}

function formatNumberWithCommas(value: number, decimals = 0) {
    return value
        .toFixed(decimals)
        .toString()
        .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>

<template>
    <div class="container">
        <h1>Provident Fund Calculator</h1>
        <div class="form-group">
            <label for="initialSalary">Initial Salary:</label>
            <input type="number" v-model="initialSalary" />
        </div>
        <div class="form-group">
            <label for="companyContributionRate"
                >Company Contribution Rate:</label
            >
            <input type="number" v-model="companyContributionRate" />
        </div>
        <div class="form-group">
            <label for="employeeContributionRate"
                >Employee Contribution Rate:</label
            >
            <input type="number" v-model="employeeContributionRate" />
        </div>
        <div class="form-group">
            <label for="salaryIncreaseRate">Salary Increase Rate:</label>
            <input type="number" v-model="salaryIncreaseRate" />
        </div>
        <div class="form-group">
            <label for="annualReturnRate">Annual Return Rate:</label>
            <input type="number" v-model="annualReturnRate" />
        </div>
        <div class="form-group custom-select">
            <label for="startMonth">Start Month:</label>
            <select v-model="startMonth">
                <option value="1">January</option>
                <option value="2">February</option>
                <option value="3">March</option>
                <option value="4">April</option>
                <option value="5">May</option>
                <option value="6">June</option>
                <option value="7">July</option>
                <option value="8">August</option>
                <option value="9">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
            </select>
        </div>
        <div class="form-group custom-select">
            <label for="endMonth">End Month:</label>
            <select v-model="endMonth">
                <option value="1">January</option>
                <option value="2">February</option>
                <option value="3">March</option>
                <option value="4">April</option>
                <option value="5">May</option>
                <option value="6">June</option>
                <option value="7">July</option>
                <option value="8">August</option>
                <option value="9">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
            </select>
        </div>
        <div class="form-group">
            <label for="startYear">Start Year:</label>
            <input type="number" v-model="startYear" />
        </div>
        <div class="form-group">
            <label for="endYear">End Year:</label>
            <input type="number" v-model="endYear" />
        </div>
        <div class="form-group">
            <label for="initialFund">Initial Fund:</label>
            <input type="number" v-model="initialFund" />
        </div>

        <button
            class="calculate-button"
            @click="
                calculateProvidentFund(
                    initialSalary,
                    companyContributionRate,
                    employeeContributionRate,
                    salaryIncreaseRate,
                    annualReturnRate,
                    startMonth,
                    endMonth,
                    startYear,
                    endYear,
                    initialFund
                )
            "
        >
            Calculate
        </button>
        <div class="results">
            <h2>
                Your Last Salary:
                {{ formatNumberWithCommas(lastSalary) }}
            </h2>
            <h2>
                Total Fund:
                {{ formatNumberWithCommas(totalFund, 2) }}
            </h2>
        </div>
    </div>
</template>

<style scoped>
.container {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

input[type="number"] {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.custom-select select {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.calculate-button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.calculate-button:hover {
    background-color: #0056b3;
}

.results {
    margin-top: 20px;
    text-align: center;
}

.results h2 {
    margin: 10px 0;
}
</style>
