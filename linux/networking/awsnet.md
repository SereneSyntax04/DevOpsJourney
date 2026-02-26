# AWS Networking Concepts

---

## 🌐 Virtual Private Cloud (VPC)

### 📖 Why VPC Was Introduced?

Earlier in traditional hosting environments: 

Multiple companies EC2 instances could be placed on shared infrastructure. If one instance or server got corrupted or compromised, it could potentially impact other companies sharing the same environment.

This created:
- Security risks
- Lack of isolation
- Limited network control

To solve this, AWS introduced **VPC (Virtual Private Cloud)**.

### 🏢 What is a VPC?

A **VPC** is your own private network inside AWS.

- Fully isolated
- Only accessible to resources and users you allow
- You control IP ranges, subnets, routing, and security

### 📏 How Do We Decide the Size of a VPC?

In real life:
- Land is measured in **acres**

In networking:
- VPC size is decided using **CIDR (Classless Inter-Domain Routing)**

Example:

```
10.0.0.0/16
```

#### What does `/16` mean?

- It defines how many IP addresses your VPC can have.
- `/16` provides:

```
65,536 total IP addresses
```

So: **CIDR range determines how large your VPC is.**

---
<br>


## 🏘 Subnet

### 📖 What is a Subnet?

A **Subnet** is a smaller network created inside a VPC.

If VPC is your land,
then subnets are like plots inside that land where you place your resources (EC2, RDS, etc.).

Example:
```
VPC: 10.0.0.0/16
```

You can divide it into:
```
Public Subnet:  10.0.1.0/24
Private Subnet: 10.0.2.0/24
```

### 🌍 Types of Subnets (Most Common in Production)

#### 1️⃣ Public Subnet
- Has route to Internet Gateway (IGW)
- Can access the internet directly
- Used for:
  - Load Balancers
  - Bastion Hosts
  - NAT Gateway

#### 2️⃣ Private Subnet
- No direct route to Internet Gateway
- Cannot be accessed directly from the internet
- Used for:
  - Application servers (EC2)
  - Databases (RDS)
  - Internal services

### Multiple Subnets ?
You can create **multiple subnets** inside a VPC.

But there are limits:
- Subnets must be within the VPC CIDR range
- Subnets cannot overlap
- AWS has a default soft limit (can be increased)

### 📌 Subnet Ranges Inside `10.0.0.0/16` (Short)

VPC CIDR: `10.0.0.0/16`  
VPC Range:
```
10.0.0.0 → 10.0.255.255
```

If creating `/24` subnets, the pattern will be:
```
10.0.0.0/24   → 10.0.0.1 – 10.0.0.254
10.0.1.0/24   → 10.0.1.1 – 10.0.1.254
10.0.2.0/24   → 10.0.2.1 – 10.0.2.254
...
10.0.255.0/24 → 10.0.255.1 – 10.0.255.254 (last possible /24)
```

Invalid (outside VPC):
```
10.1.0.0/24 ❌ (out of 10.0.0.0/16 range)
```

---
<br>


## 🌐 Internet Gateway (IGW)

### 📖 What is an Internet Gateway?

An **Internet Gateway (IGW)** is a component that allows communication between your VPC and the internet.

It acts like the **main entry and exit gate** of your VPC network.

### 🏗 Key Points

- IGW is attached to a **VPC** (not to a subnet)
- It enables:
  - Inbound internet traffic (users accessing your app)
  - Outbound internet traffic (instances accessing the internet)
- Without IGW, resources in VPC cannot be directly reached from the internet

### 🌍 How Public Users Enter the VPC

Flow:
```
Internet User → IGW → Public Subnet → Resource (EC2 / Load Balancer)
```

For this to work:
1. IGW must be attached to the VPC
2. Public subnet route table must have:
```
0.0.0.0/0 → IGW
```


### 🔓 When is a Subnet Called Public?

A subnet is considered **public** when:
- Its route table has a route to IGW
- Resources inside it have public IP (if needed)

Otherwise, it remains private even if IGW exists.


---
<br>


## ⚖️ Load Balancer

### 📖 What is a Load Balancer?

A **Load Balancer** distributes incoming user traffic across multiple servers (EC2 instances) to ensure high availability and reliability.

Instead of users directly accessing one EC2 instance, they connect to the Load Balancer.

### 🌍 Placement in Architecture

After a user enters the VPC through the IGW:
```
Internet User → IGW → Public Subnet → Load Balancer → Private Subnet EC2
```

Load Balancer is usually placed in the **Public Subnet** so it can receive internet traffic.


### 🔄 How Traffic Flow Works

1. User sends request from the internet
2. Request enters VPC via IGW
3. Lands in Public Subnet (where Load Balancer is deployed)
4. Load Balancer forwards traffic to target instances (usually in Private Subnet)

**Note:** <br>
**Route tables** route traffic at network level, but **Load Balancer** distributes traffic at application level.

---

### 🎯 Why Not Send Users Directly to EC2?

If users directly access one EC2:
- Single point of failure
- No scalability
- Overload risk

Load Balancer solves:
- Traffic distribution
- Fault tolerance
- Auto scaling integration

---
<br>



## 🛣️ Route Table

### 📖 What is a Route Table?

A **Route Table** defines how traffic is routed inside a VPC.

It contains rules that decide:
- Where should the network traffic go?
- Each subnet in a VPC is associated with a route table.


**Flow:**
```
Internet User → IGW → Route Table (Public Subnet) → Load Balancer → Private Subnet EC2
```

- IGW allows entry into VPC
- Route Table decides the path of incoming and outgoing traffic
- Then traffic reaches resources like Load Balancer or EC2


### 🏗 Example: Public Subnet Route Table

```
Destination      Target
10.0.0.0/16      local
0.0.0.0/0        IGW
```

Meaning:
- Internal VPC traffic → stays local
- Internet traffic → goes through IGW

This makes the subnet **public**.


### 🔒 Example: Private Subnet Route Table

```
Destination      Target
10.0.0.0/16      local
0.0.0.0/0        NAT Gateway
```

Meaning:
- Internal traffic → local
- Internet access (outbound) → via NAT Gateway
- No direct internet access from IGW

This keeps instances secure.

---
<br>



## 🌐 NAT Gateway

### 📖 What is a NAT Gateway?

A **NAT Gateway (Network Address Translation Gateway)** allows instances in a **private subnet** to access the internet for outbound traffic while preventing the internet from directly accessing them.

It provides **secure internet access without exposing private resources.**


### 🏗 Where is NAT Gateway Placed?

- Deployed in a **Public Subnet**
- Connected to the Internet via IGW
- Used by Private Subnet through Route Table

Architecture:
```
Private EC2 → Route Table → NAT Gateway (Public Subnet) → IGW → Internet
```

### 🔄 How It Works (Traffic Flow)

Example: `apt install apache2` from Private EC2

1. EC2 (Private Subnet) sends request to internet
2. Private subnet route table:
```
0.0.0.0/0 → NAT Gateway
```
3. NAT Gateway forwards request to Internet via IGW
4. Internet sends response back to NAT
5. NAT returns response to the private EC2 instance

**Important:**
- Internet cannot initiate connection to private instances — only responses to outbound requests are allowed.

---

### ⚠️ Key Requirements

- NAT Gateway must be in a Public Subnet
- Public Subnet must have route to IGW
- Private Subnet must route internet traffic to NAT Gateway
- NAT Gateway requires an **Elastic IP**

**Example:** <br>
Suppose:
```
Private EC2: 10.0.2.10
Destination: archive.ubuntu.com (Internet)
```

- Step 1: Outbound Request: `10.0.2.10:34567 → archive.ubuntu.com:443`<br>
**This request reaches the NAT Gateway.**

- Step 2: NAT Translates the Source IP <br>
**NAT replaces:** `Source IP: 10.0.2.10  ❌ (private, not valid on internet)` <br>
**with:** `Source IP: Elastic IP (Public) ✅
Example: 3.110.x.x
`

- Now the packet becomes:
`3.110.x.x:50001 → archive.ubuntu.com:443`

So the internet thinks:

“This request came from a public AWS IP (NAT), not the private EC2.”

Your instance identity is never exposed.

---
<br>


## 🔐 Security Group & NACL

### 📖 Security Group (Instance Level Firewall)

A **Security Group** acts as a virtual firewall for **EC2 instances.**

It controls:
- Inbound traffic (who can access the instance)
- Outbound traffic (where the instance can connect)

Key Features:
- Attached to **EC2 / ENI** (not subnet)
- **Stateful** (remembers requests)
- Only **allow** rules (no explicit deny)

Example:
```
Inbound:
Port 80  → Allow from 0.0.0.0/0 (HTTP)
Port 22  → Allow from My IP (SSH)

Outbound:
Allow All (default)
```

**Stateful behavior:** <br>
If an instance sends a request, the response is automatically allowed even if inbound rule is not explicitly defined.

---

### 🚪 NACL (Network Access Control List) – Subnet Level Firewall

A **Network ACL (NACL)** is a firewall that works at the **subnet level.**

It controls traffic entering and leaving the entire subnet.

Key Features:
- Attached to **Subnet** (not instance)
- **Stateless** (does NOT remember requests)
- Supports both **Allow and Deny** rules
- **Rules are processed in number order**

---

