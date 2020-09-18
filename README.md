# GH MS TEAMS Action

## Workflow examples:

    - name: MS Teams Nofitication
      uses: interdiscount/github-actions-ms-teams-notification@1.0.2
      with:
        webhook: ${{ secrets.MS_TEAMS_WEBHOOK }}
        service: "Hybris Backend API"
        state: "Started"
        stage: "Development"
        brand: "Interdiscount"
        version: "1.0.0"
    
    // YOUR DEPLOYMENT STEPS
    
    - name: MS Teams Nofitication
      uses: interdiscount/github-actions-ms-teams-notification@1.0.2
      if: ${{ failure() }}
      with:
        webhook: ${{ secrets.MS_TEAMS_WEBHOOK }}
        service: "Hybris Backend API"
        state: "Failed"
        stage: "Development"
        brand: "Interdiscount"
        version: "1.0.0"
         
    - name: MS Teams Nofitication
      uses: interdiscount/github-actions-ms-teams-notification@1.0.2
      if: ${{ success() }}
      with:
        webhook: ${{ secrets.MS_TEAMS_WEBHOOK }}
        service: "Hybris Backend API"
        state: "Success"
        stage: "Development"
        brand: "Interdiscount"
        version: "1.0.0"
