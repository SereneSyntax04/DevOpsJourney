
# 🌐 Networking Concepts Used in DevOps 

Think of networking like a **city**:

* IP address = house address
* Subnet = colony
* VPC = entire gated city
* Route table = Google Maps routes
* NAT Gateway = internet bridge

---

# 📌 IP ADDRESS

## 1️⃣ What is an IP Address?

An **IP Address (Internet Protocol Address)** is a unique number given to every device connected to a network (like servers, laptops, containers, etc.).

### Example:

When your app is deployed on AWS EC2, it gets an IP address so users can access it.

👉 Without IP = no communication between services.

Example:

```
192.168.1.10
```

Just like a courier needs your home address, servers need IP addresses to send data.


## 2️⃣ IPv4 vs IPv6

### 🔹 IPv4

* 32-bit address
* Most commonly used
* Limited addresses (~4.3 billion)

Example:

```
192.168.0.1
```

### 🔹 IPv6

* 128-bit address
* Created because IPv4 addresses are running out
* Used in modern cloud infrastructure

Example:

```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

### Quick Comparison

| Feature | IPv4        | IPv6        |
| ------- | ----------- | ----------- |
| Size    | 32-bit      | 128-bit     |
| Format  | Numbers     | Hexadecimal |
| Example | 192.168.1.1 | 2001:db8::1 |

**Note:** <br>
Most AWS, Kubernetes, and Docker environments still heavily use IPv4.


## 3️⃣ Format of IP Address

### IPv4 Format:

```
X.X.X.X
```

* 4 octets
* Range: 0–255

Example:

```
172.31.10.25
```

### Private IP Ranges

* 10.0.0.0 – 10.255.255.255
* 172.16.0.0 – 172.31.255.255
* 192.168.0.0 – 192.168.255.255

Used inside VPC, Kubernetes clusters, internal services.

---
<br>

# ☁️ SUBNET AND VPC 

## 1️⃣ What is VPC and Subnet?

### 🏢 VPC (Virtual Private Cloud)

A **VPC** is a virtual network inside cloud providers like AWS where you launch your resources securely.

Example:
In Amazon Web Services, you create a VPC before launching EC2, RDS, etc.

VPC = Your private data center in the cloud


### 🏘️ Subnet

A **subnet** is a smaller network inside a VPC.

Example:

```
VPC: 10.0.0.0/16
   ├── Subnet 1: 10.0.1.0/24 (Public)
   ├── Subnet 2: 10.0.2.0/24 (Private)
```

Use:

* App servers in private subnet
* Load balancer in public subnet


## 2️⃣ Public vs Private Subnet

### 🌍 Public Subnet

* Has internet access
* Used for:

  * Load Balancers
  * Bastion Host
  * Web servers (sometimes)

Condition: <br>
Must be connected to Internet Gateway


### 🔒 Private Subnet

* No direct internet access
* More secure
* Used for:

  * Databases
  * Backend services
  * Kubernetes worker nodes

**Never keep database in public subnet 🚫**


## 3️⃣ Route Table & Route Association

### 🗺️ Route Table

A **route table** decides where network traffic should go.

Example Route Table:

| Destination | Target           |
| ----------- | ---------------- |
| 0.0.0.0/0   | Internet Gateway |
| 10.0.0.0/16 | Local            |


### 🔗 Route Association

Connecting a subnet to a route table.

Example:

* Public Subnet → Route Table with IGW
* Private Subnet → Route Table with NAT


## 4️⃣ NAT Gateway 

### 🚪 What is NAT Gateway?

NAT (Network Address Translation) Gateway allows **private subnet resources to access the internet** without exposing them publicly.

Example Scenario:

* Private EC2 needs to download packages (apt install, yum update)
* NAT Gateway allows outbound internet
* But blocks inbound traffic (secure)

Flow:

```
Private Server → NAT Gateway → Internet
```

Used heavily in:

* CI/CD pipelines
* Kubernetes clusters
* Private backend services


## 5️⃣ CIDR Range 

**CIDR** = Classless Inter-Domain Routing <br>
It defines the IP range of a network.

Format:

```
IP Address / Prefix
```

Example:

```
10.0.0.0/16
```

Meaning:

* Network: 10.0.0.0
* Total IPs: ~65,536

Common CIDR in DevOps:

* /16 → Large VPC
* /24 → Subnet (256 IPs)

**AWS VPC CIDR range defines how many servers you can launch.**

---
<br>

# 🔌 PORTS 

Ports are communication endpoints used by services.

Format:

```
IP:PORT
Example: 192.168.1.10:22
```

---

## 🔥 Must-Know Ports 

| Port      | Service        | DevOps Usage            |
| --------- | -------------- | ----------------------- |
| 22        | SSH            | Server login            |
| 80        | HTTP           | Web apps                |
| 443       | HTTPS          | Secure websites         |
| 8080      | HTTP Alt       | Jenkins, Apps           |
| 21        | FTP            | File transfer           |
| 25        | SMTP           | Email sending           |
| 53        | DNS            | Domain resolution       |
| 3306      | MySQL          | Database                |
| 5432      | PostgreSQL     | Database                |
| 6379      | Redis          | Caching                 |
| 27017     | MongoDB        | NoSQL DB                |
| 6443      | Kubernetes API | Cluster communication   |
| 3000      | Node.js apps   | Dev servers             |
| 9090      | Prometheus     | Monitoring              |
| 5601      | Kibana         | Logs visualization      |
| 2375/2376 | Docker         | Container communication |

---

## 🔐 Port Types (Security Group Perspective)

* Inbound Ports → Incoming traffic
* Outbound Ports → Outgoing traffic

Example:
Allow:

```
Port 22 (SSH) → Only your IP
Port 80/443 → Public access
```

---
