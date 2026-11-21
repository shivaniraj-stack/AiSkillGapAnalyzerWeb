package com.mycompany.aiskillgapanalyzerweb.model;

public class Career {

    private int careerId;
    private String careerName;
    private String description;

    public Career() {}

    public Career(int careerId, String careerName, String description) {
        this.careerId = careerId;
        this.careerName = careerName;
        this.description = description;
    }

    public int getCareerId() { return careerId; }
    public void setCareerId(int careerId) { this.careerId = careerId; }

    public String getCareerName() { return careerName; }
    public void setCareerName(String careerName) { this.careerName = careerName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
