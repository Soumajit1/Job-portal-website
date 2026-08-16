package com.entity;

public class Jobs {

    private int id;
    private String title;
    private String description;
    private String category;
    private String status;
    private String location;
    private String pdate;

    // ID of the recruiter who posted the job
    private int recruiterId;


    // Default constructor
    public Jobs() {
        super();
    }


    // Constructor without ID
    public Jobs(String title, String description, String category,
                String status, String location, String pdate) {

        super();

        this.title = title;
        this.description = description;
        this.category = category;
        this.status = status;
        this.location = location;
        this.pdate = pdate;
    }


    // Constructor with recruiter ID
    public Jobs(String title, String description, String category,
                String status, String location, String pdate,
                int recruiterId) {

        super();

        this.title = title;
        this.description = description;
        this.category = category;
        this.status = status;
        this.location = location;
        this.pdate = pdate;
        this.recruiterId = recruiterId;
    }


    // ID
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    // Title
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    // Description
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    // Category
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }


    // Status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    // Location
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    // Publish Date
    public String getPdate() {
        return pdate;
    }

    public void setPdate(String pdate) {
        this.pdate = pdate;
    }


    // Recruiter ID
    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }
}