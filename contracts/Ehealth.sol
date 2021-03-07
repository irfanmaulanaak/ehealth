pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
// SPDX-License-Identifier: MIT

contract Ehealth{
    address manager;
    uint private idCounter;
    constructor () public {
        manager = msg.sender;
        idCounter = 0;
        addRumahSakit(0x8bD997ab0ABd89E9A23ff3cCCE5A71ddE6326f9A, "Rumah Sakit Wijaya Wiyung", 123, "Wiyung Surabaya");
    }
    
    struct Pasien {
        uint nik;
        string nama;
        uint8 umur;
        string alamat;
        string[] informasi_penyakit;
    }
    
    struct Rumah_Sakit{
        address ethaddress;
        string nama;
        uint8 idRS;
        string alamat;
    }
    Pasien[] private pasienList;
    Rumah_Sakit[] private rsList;
    
    function getManager() public view returns(address) {
        return manager;
    }
    
    //batas akhir fungsi dibawah untuk add informasi pasien & rumah sakit
    function addPasien(uint _nik, string memory _nama, uint8 _umur, string memory _alamat) isRs public{
        Pasien memory newPasien =  Pasien({
           nik:_nik,
           nama: _nama,
           umur: _umur,
           alamat:_alamat,
           informasi_penyakit: new string[](0)
        });
        pasienList.push(newPasien);
    }
    
    function addRumahSakit(address _ethaddress, string memory _nama, uint8 _idRS, string memory _alamat) isManager public {
        Rumah_Sakit memory newData = Rumah_Sakit({
           ethaddress: _ethaddress,
           nama: _nama,
           idRS: _idRS,
           alamat: _alamat
        });
        rsList.push(newData);
    }
    function addPenyakit (uint _id, string memory _penyakit) isRs public {
        require(bytes(_penyakit).length > 0);
        for(uint i; i<pasienList.length;i++){
            if(_id == pasienList[i].nik){
                pasienList[i].informasi_penyakit.push(_penyakit);
            }
        }
    }
    //batas akhir fungsi dibawah untuk add informasi pasien & rumah sakit
    
    //batas awal fungsi dibawah untuk get informasi pasien
    function getpasien_rs(uint _nik) isRs public view returns(uint, string memory, uint8, string memory){
        uint _id = 0;
        string memory _nama = '';
        uint8 _umur = 0;
        string memory _alamat = '';
        
        for(uint i = 0; i<pasienList.length;i++){
            if(_nik == pasienList[i].nik){
                _id = pasienList[i].nik;
                _nama = pasienList[i].nama;
                _umur = pasienList[i].umur;
                _alamat = pasienList[i].alamat;
            }
        }
        return(_id, _nama, _umur, _alamat);
    }
    function getpenyakit_rs(uint _nik) isRs public view returns(string[] memory){
        string[] memory _info;
        for(uint i = 0;i<pasienList.length;i++){
            if(_nik == pasienList[i].nik){
                _info = new string[](pasienList[i].informasi_penyakit.length);
                for(uint j = 0;j<pasienList[i].informasi_penyakit.length;j++){
                    _info[j] = pasienList[i].informasi_penyakit[j];
                }
            }
        }
        return(_info);
    }
    
    // function getpasien_pasien() isPasien public view returns(uint, string memory, uint8, string memory){
    //     uint _id = 0;
    //     string memory _nama = '';
    //     uint8 _umur = 0;
    //     string memory _alamat = '';
        
    //     for(uint i = 0;i<pasienList.length;i++){
    //         if(msg.sender == pasienList[i].ethaddress){
    //             _id = pasienList[i].nik;
    //             _nama = pasienList[i].nama;
    //             _umur = pasienList[i].umur;
    //             _alamat = pasienList[i].alamat;
    //         }
    //     }
    //     return(_id,_nama, _umur,_alamat);
    // }
    // function getpenyakit_pasien() isPasien public view returns(string[] memory){
    //     string[] memory _info;
    //     for(uint i = 0;i<pasienList.length;i++){
    //         if(msg.sender == pasienList[i].ethaddress){
    //             _info = new string[](pasienList[i].informasi_penyakit.length);
    //             for(uint j = 0;j<pasienList[i].informasi_penyakit.length;j++){
    //                 _info[j] = pasienList[i].informasi_penyakit[j];
    //             }
    //         }
    //     }
    //     return(_info);
    // }
    //batas akhir fungsi get info pasien
    
    //batas awal untuk fungsi get info rumah sakit
    
    function getinfors(uint8 _idRS) isManager public view returns(address, string memory, uint8, string memory){
        address _ethaddress;
        string memory _nama;
        string memory _alamat;
        
        for(uint i = 0; i<rsList.length;i++){
            if(_idRS == rsList[i].idRS){
                _ethaddress = rsList[i].ethaddress;
                _nama = rsList[i].nama;
                _idRS = rsList[i].idRS;
                _alamat = rsList[i].alamat;
            }
        }
        return(_ethaddress, _nama, _idRS, _alamat);
    }
    
    //batas akhir untuk fungsi get info rumah sakit
    // function check_pasien() public view returns(bool){
    //     for(uint i = 0; i < pasienList.length;i++){
    //         if(msg.sender == pasienList[i].ethaddress){
    //             return true;
    //         }
    //     }
    // }
    
    function check_rs() public view returns(bool) {
        for(uint i = 0; i<rsList.length;i++){
            if(msg.sender == rsList[i].ethaddress){
                return true;
            }
        }
    }

    modifier isManager(){
        require (manager == msg.sender);
        _;
    }
    modifier isRs(){
        require (check_rs());
        _;
    }
    // modifier isPasien(){
    //     require(check_pasien());
    //     _;
    // }
    // modifier permissionData(){
    //     require(check_rs() || check_pasien());
    //     _;
    // }
    
}
