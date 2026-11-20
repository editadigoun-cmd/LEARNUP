export type Rating=0|1|2|3;
export type ReviewState={ease:number;intervalDays:number;repetitions:number};
export function nextReview(state:ReviewState,rating:Rating,now=new Date()):ReviewState&{dueAt:Date}{
 const ease=Math.max(1.3,state.ease+(0.1-(3-rating)*(0.08+(3-rating)*0.02)));
 let repetitions=rating<2?0:state.repetitions+1;
 let interval=rating<2?1:repetitions===1?1:repetitions===2?3:Math.round(state.intervalDays*ease);
 if(rating===0)interval=1;
 const dueAt=new Date(now);dueAt.setDate(dueAt.getDate()+interval);
 return {ease:Number(ease.toFixed(2)),intervalDays:interval,repetitions,dueAt};
}
export type AnswerEvent={correct:boolean;difficulty:"easy"|"medium"|"hard";answeredAt:Date};
export function masteryFromAnswers(events:AnswerEvent[],now=new Date()):number{
 if(!events.length)return 0;
 const weights={easy:1,medium:1.25,hard:1.5};
 let earned=0,total=0;
 for(const event of events){const ageDays=Math.max(0,(now.getTime()-event.answeredAt.getTime())/86400000);const recency=Math.max(.4,1-ageDays*.03);const weight=weights[event.difficulty]*recency;total+=weight;if(event.correct)earned+=weight;}
 return Math.round(earned/total*100);
}
export function quizScore(correct:number,total:number){if(total<=0||correct<0||correct>total)throw new RangeError("Invalid quiz result");return Math.round(correct/total*100);}
export type ChapterState={chapterId:string;mastery:number;dueCount:number};
export function prioritizedChapters(chapters:ChapterState[]){return [...chapters].sort((a,b)=>(a.mastery-b.mastery)|| (b.dueCount-a.dueCount));}
