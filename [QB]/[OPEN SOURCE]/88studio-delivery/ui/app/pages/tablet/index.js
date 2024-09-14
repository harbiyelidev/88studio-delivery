import importTemplate from "../../utils/importTemplate.js";

export default {
    data() {
        return {
            isJobSelected: false,
            selectedJob: {
                id: "select-a-job",
                level: 1,
                image: "bg-0",
                name: "...",
                description: "...",
            },
            selectedCar: {
                id: "",
                name: "",
                description: "",
                image: "",
            },
            carList: {},
        }
    },
    computed: {
        ...Vuex.mapState({
            isPhoneActive: state => state.isPhoneActive,
            isTabletActive: state => state.isTabletActive,
            Locales : state => state.Locales,
            Jobs : state => state.Jobs,
            Cars : state => state.Cars,
            userDetail: state => state.userDetail,
        })
    },
    methods: {
        ...Vuex.mapMutations({
            setIsTabletActive: "setIsTabletActive",
        }),
        ButtonHover() {
            const sound = new Audio('./assets/audio/hoversound.wav');
            sound.volume = 0.2;
            sound.play();
        },
        SelectSound(target, bool) {
            if (bool) {
                if (target.id != this.selectedJob.id && this.userDetail.currentLevel >= target.level && !this.isJobSelected) {
                    const sound = new Audio('./assets/audio/selectsound.wav');
                    sound.volume = 0.2;
                    sound.play();

                    return;
                }
                if (target.id != this.selectedCar.id && this.userDetail.currentLevel >= target.level && this.isJobSelected) {
                    const sound = new Audio('./assets/audio/selectsound.wav');
                    sound.volume = 0.2;
                    sound.play();

                    return;
                }
            } else if (target == null && bool == false) {
                const sound = new Audio('./assets/audio/selectsound.wav');
                sound.volume = 0.2;
                sound.play();
            }
        },
        ChooseJob(job) {
            if (this.selectedJob.id != job.id && this.userDetail.currentLevel >= job.level) {
                this.selectedJob = {
                    id: job.id,
                    level: job.level,
                    image: job.image,
                    name: job.name,
                    description: job.description,
                }
            }
        },
        ChooseCar(vehicle) {
            if (this.selectedCar.id != vehicle.id && this.userDetail.currentLevel >= vehicle.level) {
                this.selectedCar = {
                    id: vehicle.id,
                    name: vehicle.name,
                    description: vehicle.description,
                    image: vehicle.image,
                }
            }
        },
        TransitionBetweenPages() {
            if (this.isJobSelected) {
                this.carList = {};
                this.isJobSelected = false;
                return;
            }

            if (this.selectedJob.level <= this.userDetail.currentLevel && this.selectedJob.id) {
                this.isJobSelected = true;
                return;
            }
        },
        SetupVehicleList() {
            this.carList = this.Cars[this.selectedJob.id];
            return this.carList;
        },
        StartDuty() {
            if (this.selectedJob.id == 'select-a-job' || this.selectedCar.id == '' || !this.isJobSelected) return;
            postNUI('startDuty', {
                job: this.selectedJob.id,
                vehicle: this.selectedCar.id,
            });
            postNUI('close');
            this.setIsTabletActive(false)
        },
        keyHandler(e) {
            if (e.which == 27) {
                postNUI('close');
                this.setIsTabletActive(false)
            }
        },
    },
    mounted() {
        window.addEventListener("message", this.messageHandler);
        window.addEventListener("keyup", this.keyHandler);
    },
    beforeDestroy() {
        window.removeEventListener("message", this.messageHandler);
        window.removeEventListener("keyup", this.keyHandler);
    },
    template: await importTemplate("./app/pages/tablet/index.html")
};