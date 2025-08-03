# Google Drive API Setup Guide

This guide will help you set up Google Drive API access for the WhatsApp Drive Assistant.

## Step 1: Create Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the following APIs:
   - Google Drive API
   - Google Sheets API (for logging)

## Step 2: Create OAuth 2.0 Credentials

1. Go to **APIs & Services** → **Credentials**
2. Click **+ CREATE CREDENTIALS** → **OAuth client ID**
3. Choose **Web application**
4. Set **Authorized redirect URIs**:
   ```
   http://localhost:5678/oauth2/callback
   https://your-domain.com:5678/oauth2/callback
   ```
5. Download the JSON file and note:
   - Client ID
   - Client Secret

## Step 3: Configure OAuth Consent Screen

1. Go to **APIs & Services** → **OAuth consent screen**
2. Choose **External** user type
3. Fill in required fields:
   - App name: "WhatsApp Drive Assistant"
   - User support email
   - Developer contact information
4. Add scopes:
   - `https://www.googleapis.com/auth/drive.file`
   - `https://www.googleapis.com/auth/drive.readonly`
   - `https://www.googleapis.com/auth/spreadsheets`

## Step 4: Configure n8n Credentials

1. Open n8n at http://localhost:5678
2. Go to **Settings** → **Credentials**
3. Add **Google Drive OAuth2** credential:
   - Client ID: Your Google OAuth Client ID
   - Client Secret: Your Google OAuth Client Secret
   - Scope: `https://www.googleapis.com/auth/drive.file https://www.googleapis.com/auth/drive.readonly`
4. Click **Connect** and authorize access

## Step 5: Test Drive Access

Create a test folder in your Google Drive and try:
```
LIST /YourTestFolder
```

## Common Issues

### Issue: "Access denied" error
**Solution**: Check OAuth scopes and ensure APIs are enabled

### Issue: "Invalid redirect URI"
**Solution**: Verify redirect URI matches exactly in Google Console

### Issue: "Quota exceeded"
**Solution**: Check API quotas in Google Cloud Console

## Required Scopes

```
https://www.googleapis.com/auth/drive.file
https://www.googleapis.com/auth/drive.readonly
https://www.googleapis.com/auth/spreadsheets
```

## Security Best Practices

1. Use least privilege scopes
2. Regularly rotate OAuth tokens
3. Monitor API usage
4. Implement access logging
5. Use service accounts for production