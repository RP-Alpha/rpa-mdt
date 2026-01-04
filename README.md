# rpa-mdt

<div align="center">

![GitHub Release](https://img.shields.io/github/v/release/RP-Alpha/rpa-mdt?style=for-the-badge&logo=github&color=blue)
![GitHub commits](https://img.shields.io/github/commits-since/RP-Alpha/rpa-mdt/latest?style=for-the-badge&logo=git&color=green)
![License](https://img.shields.io/github/license/RP-Alpha/rpa-mdt?style=for-the-badge&color=orange)
![Downloads](https://img.shields.io/github/downloads/RP-Alpha/rpa-mdt/total?style=for-the-badge&logo=github&color=purple)

**Mobile Data Terminal for Emergency Services**

</div>

---

## ✨ Features

- 📊 **Dashboard** - Quick view of warrants and BOLOs
- 🔍 **Database Search** - Lookup citizens and vehicles
- 📝 **Reports** - Create and manage incident reports
- ⚠️ **Warrants & BOLOs** - Issue and manage alerts
- 🚔 **Criminal Records** - Track offenses and charges
- 📱 **Tablet Animation** - Immersive prop usage
- 🔐 **Permission System** - Role-based access control

---

## 📦 Dependencies

- `rpa-lib` (Required)
- `oxmysql` (Required)

---

## 📥 Installation

1. Download the [latest release](https://github.com/RP-Alpha/rpa-mdt/releases/latest)
2. Extract to your `resources` folder
3. Import the database:
   ```sql
   source sql/install.sql
   ```
4. Add to `server.cfg`:
   ```cfg
   ensure rpa-lib
   ensure rpa-mdt
   ```

---

## 🗄️ Database Tables

- `rpa_mdt_reports` - Incident reports
- `rpa_mdt_warrants` - Active warrants
- `rpa_mdt_bolos` - Be On Lookout alerts
- `rpa_mdt_records` - Criminal records
- `rpa_mdt_notes` - Officer notes
- `rpa_mdt_dispatch` - Dispatch log

---

## ⚙️ Configuration

### Access Permissions

```lua
Config.AccessPermissions = {
    groups = {},
    jobs = { 'police', 'ambulance', 'sheriff' },
    minGrade = 0,
    onDuty = true
}
```

### Warrant Permissions

```lua
Config.ManageWarrantsPermissions = {
    groups = { 'admin' },
    jobs = { 'police', 'sheriff' },
    minGrade = 3  -- Sergeants and above
}
```

---

## ⌨️ Controls

| Key | Action |
|-----|--------|
| `K` | Open MDT (Police/EMS only) |

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/RP-Alpha">RP-Alpha</a></sub>
</div>
