import React from "react";
import {createComprehensionRootStore, initComprehensionApp, StoreProvider} from "../utils/ComprehensionUtils";
import ComprehensionStudent from "./ComprehensionStudent";
import ComprehensionLecturer from "./ComprehensionLecturer";

const rootStore = createComprehensionRootStore();

interface IComprehensionAppProps {
    user_id: number,
    is_student: boolean,
    lecture_id: number
}

const ComprehensionApp: React.FunctionComponent<IComprehensionAppProps> = ({ user_id, is_student, lecture_id }) => {
    rootStore.setUserId(user_id);
    rootStore.setIsStudent(is_student);
    rootStore.setLectureId(lecture_id);
    rootStore.setActiveStamp(2);
    initComprehensionApp(rootStore);
    return (
        <StoreProvider value={rootStore}>
            <div className="ComprehensionApp">
                {is_student && <ComprehensionStudent />}
                {!is_student && <ComprehensionLecturer />}
            </div>
        </StoreProvider>
    )
};
export default ComprehensionApp;