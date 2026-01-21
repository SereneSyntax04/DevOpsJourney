
<h1 align='center'> Case Study: 21 CFR Part 11 + SSO </h1>

## Company Background (Typical Scenario)

**Company:** Pharma / Biotech / Medical Devices company  
**Regulation:** FDA (US)  
**Systems Used:**
- LIMS (Lab Information Management System)
- QMS (Quality Management System)
- DMS (Document Management System)
- Manufacturing Execution System (MES)

**Cloud:** AWS  
**Identity Provider (SSO):** Okta / Azure AD  
**Users:** Lab technicians, QA, Managers, IT admins, Auditors

---

## Why Organizations Use SSO with Part 11 

### Short answer:
Organizations use SSO because it helps satisfy multiple Part 11 requirements reliably and at scale.

SSO is not required by Part 11, but it is one of the most effective ways to enforce the identity, access, and audit controls that Part 11 expects

### Real reasons :

1. **Too many systems**
   - LIMS, QMS, DMS, MES — each needs authentication
   - Without SSO → separate usernames/passwords → chaos

2. **Auditors hate weak identity control**
   - Shared accounts
   - Ex-employees still having access
   - No centralized audit

3. **Password fatigue causes violations**
   - Users write passwords on sticky notes
   - Reuse passwords
   - Lockouts during critical lab work

👉 **SSO fixes all of this** *if implemented correctly*.

---

## Core Problem Statement

> “How do we meet 21 CFR Part 11 requirements **and** make life easier for users?”

Answer: **Centralized identity (SSO) + strict Part 11 controls inside the app**

---

## Architecture 

```

User
↓ (Login)
SSO / IdP (Okta / Azure AD)
↓ (OIDC / SAML token with User ID, MFA, roles)
FDA-Regulated App (LIMS / QMS)
↓
Audit Trail + Electronic Records (Immutable)
↓
AWS Storage (S3 + CloudTrail + Logs)

```

---

## How Each Part 11 Requirement Is Met (With SSO)

## 1️⃣ Unique User Identification

### Part 11 Rule:
Every user must be **uniquely identifiable**.

### How SSO helps:
- Each user has **one corporate identity** in IdP
- No shared logins
- When employee leaves → account disabled → access revoked everywhere

### Example:
```

Username: [shrushti.shrivastav@scitara.com](mailto:shrushti.shrivastav@scitara.com)
UserID: okta-9a82kks9

```

The application **stores this ID**, not just “SSO user”.

---

## 2️⃣ Authentication (Strong Login)

### Part 11 Expectation:
Secure, reliable authentication (especially for critical actions).

### SSO Implementation:
- MFA enforced at IdP
  - Password + OTP / Push / Hardware token
- Password policy centralized (length, expiry, lockout)

### Example:
- Login to Okta → MFA required
- Token issued only after MFA success

✅ One strong login  
✅ No app-level password mess

---

## 3️⃣ Audit Trails (MOST IMPORTANT)

### Part 11 Rule:
System must record:
- Who did what
- When
- Before/after values
- Cannot be altered

### Common SSO mistake:
> “The app only logs `SSO_user`”

🚨 **That FAILS Part 11**

### Correct approach:
- App extracts:
  - User ID
  - Username
  - Role
- Stores it **per action**

### Example Audit Log Entry:
```

User: [shrushti.shrivastav@scitara.com](mailto:shrushti.shrivastav@scitara.com)
UserID: okta-9a82kks9
Action: Modified Test Result
Old Value: 4.5 mg
New Value: 4.8 mg
Timestamp: 2026-01-21T09:12:00Z
Reason: Re-test due to instrument recalibration

```

✅ Fully traceable  
✅ Immutable logs 

---

## 4️⃣ Electronic Signatures (Critical Area)

### Part 11 Rule:
Electronic signatures must be:
- Unique
- Linked to the record
- Non-reusable
- Verifiable

### How SSO fits:
SSO **does NOT replace** e-signature logic.

👉 Login ≠ Signature

### Correct flow:
1. User logs in via SSO
2. User clicks **“Sign Record”**
3. System prompts:
   - Re-authentication OR
   - Password confirmation OR
   - MFA confirmation
4. Signature stored with:
   - User ID
   - Meaning (Approve / Review)
   - Timestamp

### Example:
```

Signed By: [shrushti.shrivastav@scitara.com](mailto:shrushti.shrivastav@scitara.com)
Signature Meaning: QA Approval
Date: 21-Jan-2026 09:30
Linked Record: Batch#B-2026-045

```

✅ SSO used for identity  
✅ App controls signature

---

## 5️⃣ Role-Based Access Control (RBAC)

### Part 11 Expectation:
Only authorized users can perform certain actions.

### SSO Advantage:
Roles managed centrally.

### Example:
| Role | Permissions |
|----|-----------|
| Lab Technician | Enter results |
| QA | Review + Sign |
| Manager | Final approval |
| Auditor | Read-only |

### Token contains:
```

roles: ["QA", "Reviewer"]

```

Application enforces:
- QA can sign
- Technician cannot


---

## 6️⃣ Record Retention & Retrieval

### Part 11 Rule:
Records must be:
- Retained for years
- Easily retrievable
- Tamper-proof

### Typical AWS Setup:
- Audit logs → CloudWatch + S3
- Records → S3 Object Lock (WORM)
- Access logs → CloudTrail

SSO logs:
- Login
- Logout
- Failed attempts

Application logs:
- Data changes
- Signatures
- Approvals

✅ End-to-end traceability

---

## Why This Model Is Used *Mostly Everywhere*

### Without SSO:
- User provisioning takes days
- IT manually creates users in each system
- Ex-employee risk
- Audit findings

### With SSO:
- One identity source
- Faster onboarding/offboarding
- Strong security
- Cleaner audits
- Happier users

That’s why **almost every modern FDA-regulated org uses SSO now**.

---

## Common Audit Questions 

### Q: Does SSO violate Part 11?
**Answer:** No, if user identity, audit trails, and e-signatures are properly implemented.

### Q: How do you ensure identity traceability?
**Answer:** We propagate the unique IdP user ID into application audit trails.

### Q: Is MFA enforced?
**Answer:** Yes, centrally via IdP for all regulated systems.

### Q: Can audit logs be altered?
**Answer:** No, logs are immutable and stored in WORM-enabled storage.

---
<br>




