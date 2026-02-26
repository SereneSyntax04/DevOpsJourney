## 🌐 OSI Model 

The **OSI (Open Systems Interconnection) Model** is a 7-layer framework that explains **how data travels from one device to another over a network**.

It breaks networking communication into structured layers so that:

* Systems from different vendors can communicate
* Engineers can troubleshoot easily
* Networking becomes standardized

It was developed by the International Organization for Standardization.

---

### 🧱 7 Layers (Top to Bottom)

1. Application
2. Presentation
3. Session
4. Transport
5. Network
6. Data Link
7. Physical

---

## 🌍 How DNS Resolution & Handshake Fit into the OSI Model

When you type a website like `www.example.com` in your browser, two major things happen before the page loads:

1. DNS Resolution (finding the IP address)
2. TCP Handshake (establishing connection)

### 🔎 Step 1: DNS Resolution (Domain → IP Address)

#### 🧠 What is DNS?

DNS (Domain Name System) translates human-friendly domain names into IP addresses that computers understand.

Example:
`google.com` → `142.250.xxx.xxx`

---

#### 📡 DNS Resolution Flow with OSI Layers

#### 🖥️ Layer 7 – Application Layer

* You enter a URL in the browser
* Browser sends a DNS query request
* Protocol Used: **DNS**

`“Hey DNS server, what is the IP of this domain?”`

---

#### 🔐 Layer 6 – Presentation Layer

* Data formatting & encryption (if needed)
* Converts the request into proper format (UTF-8, etc.)

---

#### 🔗 Layer 5 – Session Layer

* Establishes session between your device and DNS resolver
* Keeps track of request & response

```
Above 3 layers are handled by browser itself (layer 7,6,5)
```

---

#### 🚚 Layer 4 – Transport Layer (TCP/UDP)

* DNS usually uses **UDP (Port 53)** for fast queries
* If response is large → switches to TCP
 
Key Role:

* Adds Source Port & Destination Port


##### Common TCP Protocol Examples

| Protocol | Uses TCP? | Default Port | Why TCP?                        |
| -------- | --------- | ------------ | ------------------------------- |
| HTTP     | ✅ Yes     | 80           | Reliable webpage loading        |
| HTTPS    | ✅ Yes     | 443          | Secure + reliable data transfer |
| FTP      | ✅ Yes     | 21           | File transfer needs accuracy    |
| SMTP     | ✅ Yes     | 25           | Reliable email sending          |
| SSH      | ✅ Yes     | 22           | Secure remote login             |


##### Common UDP Protocol Examples

| Protocol                 | Uses UDP?      | Default Port | Why UDP?                |
| ------------------------ | -------------- | ------------ | ----------------------- |
| DNS                      | ✅ Yes (mostly) | 53           | Fast query-response     |
| DHCP                     | ✅ Yes          | 67/68        | Quick IP assignment     |
| VoIP                     | ✅ Yes          | Varies       | Real-time voice calls   |
| Streaming (Video/Gaming) | ✅ Yes          | Varies       | Low latency needed      |
| SNMP                     | ✅ Yes          | 161          | Fast network monitoring |

Here’s a clearer and slightly more detailed explanation (still simple & revision-friendly):

---

### 🗺️ Layer 3 – Network Layer (IP Layer)

* Adds **Source IP** (your device IP) and **Destination IP** (DNS Server IP)
* Decides how the packet will travel across multiple networks
* Uses routing tables to choose the best path
* Protocols: **IP, ICMP**
* Your laptop creates a packet
* Source IP: `192.168.1.10` (your system)
* Destination IP: `8.8.8.8` (DNS server)
* Router reads the destination IP and forwards it to the next network

---

### 🧾 Layer 2 – Data Link Layer (MAC & Framing)

* Converts packets into **frames**
* Adds **MAC Address** of:

  * Source device
  * Next hop (usually the router)
* Performs error detection (CRC)
* Works only within the same network (LAN)
* System checks: “Is DNS server in my network?”
* If NOT → sends frame to **default gateway (router)**
* Frame contains:

  * Source MAC: Your Laptop MAC
  * Destination MAC: Router MAC

Example:

```
IP Packet → Encapsulated into Frame
Frame = [Source MAC | Destination MAC | Data]
```

💡 Think of this as a **delivery person handing the parcel to the nearest post office (router).**

---

### 🔌 Layer 1 – Physical Layer (Transmission Layer)

- Actual data transmission as bits (0s and 1s)

* Converts frames into electrical signals, light signals, or radio waves
* Sends data through:

  * Ethernet cable (electrical signals)
  * Fiber (light pulses)
  * WiFi (radio signals)
* Bits travel from:

  * Your device → Router → ISP → DNS Server
* No understanding of IP, ports, or protocols
* Just raw bit transmission: `101010101`

💡 Think of this as the **physical road/cable/wire** where data actually travels.

---
<br>

## 📩 DNS Response Returns

Once the DNS server finds the correct IP address, it sends a **DNS response** back to your system.

Example response:

```
Domain: example.com
IP Address: 93.184.216.34
```

But internally, more things are happening 👇

---

### 🔄 How the DNS Response Travels Back (OSI Flow Reverse)

The response follows the **same 7 layers**, but in reverse order.

#### 🔌 Layer 1 – Physical

Signals (bits) travel back through:

* DNS Server → ISP → Router → Your Device

#### 🧾 Layer 2 – Data Link

* Frames are created at each hop
* MAC addresses change at every router
* Error detection is performed

💡 Important: **MAC changes at every hop**, but IP stays the same.

#### 🗺️ Layer 3 – Network

* Source IP: DNS Server
* Destination IP: Your Device
* Routers forward the packet based on destination IP

#### 🚚 Layer 4 – Transport

* Usually UDP (Port 53)
* If response is large → TCP may be used
* Port numbers ensure response goes back to correct application (browser)

Example:

```
Source Port: 53
Destination Port: Random client port (like 49532)
```

#### 🔗 Layer 5 – Session

* Maintains the query-response session
* Matches response to the correct request


#### 🔐 Layer 6 – Presentation

* Data is decoded into readable format
* Converts binary response into structured DNS record


#### 🖥️ Layer 7 – Application

* Browser receives DNS response
* Extracts IP address
* Stores it temporarily in DNS cache (to avoid asking again)


### 📦 What Actually Comes in DNS Response?

The DNS response contains:

* **A Record** → Maps domain to IPv4 address
* **TTL (Time To Live)** → How long to cache the result
* Query ID → To match request & response

Example (simplified):

```
example.com  →  93.184.216.34
TTL: 300 seconds
```

#### 🚀 What Happens Next?

Now that browser has the IP address:

1. It initiates **TCP 3-way handshake**
2. Then (if HTTPS) → TLS handshake
3. Then sends HTTP request

---
<br>


### 🤝 Step 2: TCP 3-Way Handshake (Connection Establishment)

After getting the IP, your system connects to the web server.

This happens mainly at **Transport Layer (Layer 4)**.

---

### 🔄 TCP 3-Way Handshake 

#### 🧾 Step 1: SYN (Client → Server)

* Client sends SYN packet
* Means: “I want to start a connection”

OSI Mapping:

* L4: TCP adds SYN flag
* L3: Adds IP
* L2: Frame
* L1: Signal sent

---

#### 📬 Step 2: SYN-ACK (Server → Client)

* Server replies with SYN + ACK
* Means: “Connection accepted”

---

#### ✅ Step 3: ACK (Client → Server)

* Client sends ACK
* Connection established successfully

Now a reliable connection is ready!

---

## 🔒 TLS/SSL Handshake (Secure Websites – HTTPS)

If the website uses HTTPS (like most sites today):

* Happens after TCP handshake
* Encryption keys are exchanged
* Secure channel is created

Protocols:

* TLS (Transport Layer Security)
* Works between Layer 4–7 logically

---

# 📚 Real-World Flow 

1. You type `amazon.com`
2. DNS resolves domain → IP (Layer 7 → 1)
3. TCP Handshake happens (SYN → SYN-ACK → ACK)
4. TLS Handshake (if HTTPS)
5. HTTP Request sent
6. Server responds with webpage data

---
