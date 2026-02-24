
# 🌐 What is CIDR?

**CIDR (Classless Inter-Domain Routing)** is a way to define:

* How many IP addresses are in a network
* Which part is **network portion**
* Which part is **host portion**

Format:

```
IP_Address / Prefix
Example:
10.0.0.0/16
```

The number after `/` is the **subnet mask length**.

---

# 🧠 First Understand This 

An IPv4 address has:

```
32 bits total
```

Example:

```
10.0.0.0
```

Internally it is binary (you don't need to memorize fully, just understand concept):

Each number = 8 bits
So:

```
8 + 8 + 8 + 8 = 32 bits
```

---

# 🔢 What Does `/16` Mean?

Example:

```
10.0.0.0/16
```

This means:

* First 16 bits = Network portion
* Remaining 16 bits = Host portion

So:

```
32 - 16 = 16 bits for hosts
```

Now calculate number of IPs:

```
2^16 = 65,536 total IPs (256 * 256)
```

But 2 are reserved:

* 1 Network address
* 1 Broadcast address

So usable:

```
65,534 usable IPs
```

**NOTE:**
In **AWS** subnet reserves 5 IPs,
```
-Network address
-Router
-DNS
-Future use
-Broadcast

So actual usable in /24:
256 - 5 = 251 usable IPs (AWS specific)

```

---

# 🧮 Formula to Calculate IP Count

```
Total IPs = 2^(32 - CIDR)
Usable IPs = Total - 2
```

Example:

```
/24
2^(32-24) = 2^8 = 256
Usable = 254
```

---

# 📊 Common CIDR Ranges (VERY IMPORTANT)

| CIDR | Total IPs | Usable IPs | Usage          |
| ---- | --------- | ---------- | -------------- |
| /32  | 1         | 1          | Single host    |
| /30  | 4         | 2          | Point-to-point |
| /24  | 256       | 254        | Small subnet   |
| /16  | 65,536    | 65,534     | Large VPC      |
| /8   | 16M+      | Huge       | Enterprise     |

---

# 🏢 Real DevOps Example in AWS

In Amazon Web Services:

When creating VPC:

```
VPC CIDR: 10.0.0.0/16
```

Inside that VPC, you create subnets:

```
Public Subnet: 10.0.1.0/24
Private Subnet: 10.0.2.0/24
```

Explanation:

* VPC has 65,536 IPs
* Each subnet has 256 IPs
* You can create multiple /24 inside /16

Think like:

```
VPC = Big apartment building
Subnets = Floors
IPs = Rooms
```

---

# 🧱 How Subnetting Actually Works (Step-by-Step)

Start:

```
10.0.0.0/16
```

Now you want smaller subnets.

If you change to:

```
10.0.0.0/24
```

You increased network bits from 16 → 24.

That means:

* Borrowed 8 bits from host part
* Created smaller networks
* Reduced IPs per subnet

More network bits → Smaller subnet
Fewer network bits → Bigger subnet

---

# 🎯 Visual Understanding

Example:

```
/16 = 10.0.0.0 - 10.0.255.255
```

If split into /24:

```
10.0.0.0/24
10.0.1.0/24
10.0.2.0/24
...
10.0.255.0/24
```

Each has:

```
256 IPs
```

Total possible /24 inside /16:

```
256 subnets
```

---

### Q: Why not use /8 always?

Example:

```
10.0.0.0/8
```

This gives:

```
16 million IPs
```

Problem:

* Hard to manage
* Security risk
* Routing complexity
* Waste of IP space

Best practice:
Use:

```
/16 for VPC
/24 for subnets
```

---

# 🛑 Network Address & Broadcast Address

Example:

```
192.168.1.0/24
```

Range:

```
192.168.1.0 → Network Address (cannot use)
192.168.1.255 → Broadcast Address (cannot use)
192.168.1.1 - 192.168.1.254 → usable
```

---

# 🔐 Private CIDR Ranges (Used in Cloud)

Very important for DevOps:

| Range                         | CIDR           |
| ----------------------------- | -------------- |
| 10.0.0.0 – 10.255.255.255     | 10.0.0.0/8     |
| 172.16.0.0 – 172.31.255.255   | 172.16.0.0/12  |
| 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 |

Used inside:

* VPC
* Kubernetes clusters
* Docker networks

---

# 🧩 CIDR in Kubernetes

In Kubernetes:

* Pod CIDR
* Service CIDR

Example:

```
Pod Network: 192.168.0.0/16
Service Network: 10.96.0.0/12
```

CIDR ensures pods don’t conflict with VPC IPs.

---

# 🚀 CIDR Planning in Real DevOps

When designing production:

1. Choose VPC CIDR large enough
2. Divide into:

   * Public subnet
   * Private subnet
   * Database subnet
3. Leave room for scaling

Example design:

```
VPC: 10.0.0.0/16

Public: 10.0.1.0/24
Private-App: 10.0.2.0/24
Private-DB: 10.0.3.0/24
Future: 10.0.4.0/24
```

Always plan future expansion.

---

## 🔥 5 Reasons Large CIDR Is NOT Wasteful

### 1️⃣ Future Scaling (Most Important)

Today:

`10 servers`

Tomorrow:

```
500 containers (Kubernetes)

Auto Scaling Groups

Load balancers

Microservices
```

If you choose small CIDR like /24, you will run out of IPs FAST.

### 2️⃣ Kubernetes Needs Huge IP Space

In DevOps environments:

Each pod gets an IP

Each node gets multiple IPs

Example:

`100 nodes × 50 pods = 5000+ IPs needed`

- A /24 (254 IPs) will fail immediately ❌

### 3️⃣ You Cannot Expand VPC CIDR Easily Later

This is a **BIG** cloud limitation.

If your VPC is:

`10.0.0.0/24`

And it fills up:

- Migration becomes painful
- Requires new VPC
- Re-architecture needed
- So engineers plan BIG from start.

### 4️⃣ Subnet Planning Flexibility

With /16 VPC, you can create:

```
256 subnets of /24
OR
64 subnets of /18
OR
Mix of different subnet sizes
```

You get architectural freedom.

### 5️⃣ IPs Are Virtual (Not Physical Cost)

Cloud providers do NOT charge for unused private IPs inside CIDR.

So:

Idle CIDR space = No cost + High flexibility

---